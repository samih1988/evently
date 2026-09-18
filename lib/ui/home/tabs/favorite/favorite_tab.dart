import 'package:evently/fireStore/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:evently/ui/widgets/custom_item_event.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_utilz.dart';
import '../../../widgets/custom_text_form_field.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  List<Event> favouriteList = [];
  Stream<List<Event>>? favouriteStream;
  String eventSearch = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteStream = FirebaseUtils.getAllIsFavourite();
  }

  void updateStream(String nameSearch) {
    eventSearch = nameSearch;
    if (eventSearch.isEmpty) {
      favouriteStream = FirebaseUtils.getAllIsFavourite();
    } else {
      favouriteStream =
          FirebaseUtils.getSearchFavourite(eventName: eventSearch);
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(height * .02),
        child: Column(
          spacing: height * .02,
          children: [
            CustomTextFormField(
              onChanged: (eventNameSearch) {
                updateStream(eventNameSearch);
              },
              borderColor: Theme
                  .of(context)
                  .highlightColor,
              hinttext: AppLocalizations.of(context)!.search_for_event,
              hintstyle: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,
              sufixIcon: Icon(
                Icons.search_outlined,
                color: Theme
                    .of(context)
                    .cardColor,
                size: 35,
              ),

            ),
            Expanded(child:
            StreamBuilder(
              stream: favouriteStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme
                          .of(context)
                          .cardColor,
                    ),
                  );
                }
                if (!snapshot.hasData && snapshot.data!.isEmpty) {
                  return Text(
                    'no data found',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  );
                } else {
                  favouriteList = snapshot.data!;
                  return favouriteList.isEmpty
                      ? Center(
                    child: Text(
                      'no data found',
                      style: Theme
                          .of(
                        context,
                      )
                          .textTheme
                          .headlineMedium,
                    ),
                  )
                      : ListView.separated(
                    itemBuilder: (context, index) {
                      return CustomItemEvent(
                        event: favouriteList[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: height * .02),
                    itemCount: favouriteList.length,
                  );
                }
              },
            )
            ),
          ],
        ),
      ),
    );
  }
}
