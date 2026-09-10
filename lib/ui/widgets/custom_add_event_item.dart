import 'package:flutter/material.dart';

import '../../utils/app_utilz.dart';

class CustomAddEventItem extends StatelessWidget {
  final String imagePth;

  const CustomAddEventItem({super.key, required this.imagePth});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Container(
      height: height * .25,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).shadowColor, width: 2),
        image: DecorationImage(image: AssetImage(imagePth), fit: BoxFit.fill),
      ),
    );
  }
}
