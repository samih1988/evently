import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home/tabs/favorite/favorite_tab.dart';
import 'package:evently/ui/home/tabs/home/home_tab.dart';
import 'package:evently/ui/home/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screenLists = [HomeTab(), FavoriteTab(), ProfileTab()];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },
        items: [
          _buildBottomNavigationBarItem(
            inActiveIcon: Icons.home_outlined,
            activeIcon: Icons.home_filled,
            label: AppLocalizations.of(context)!.home,
          ),
          _buildBottomNavigationBarItem(
            inActiveIcon: Icons.favorite_outline,
            activeIcon: Icons.favorite,
            label: AppLocalizations.of(context)!.favorite,
          ),
          _buildBottomNavigationBarItem(
            inActiveIcon: Icons.person_outlined,
            activeIcon: Icons.person,
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
      body: screenLists[selectedIndex],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData activeIcon,
    required IconData inActiveIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: Icon(activeIcon),
      icon: Icon(inActiveIcon),
      label: label,
    );
  }
}
