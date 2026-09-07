import 'package:flutter/material.dart';

class ProfileUserChosing extends StatelessWidget {
  String textName;
  Widget iconName;

  ProfileUserChosing({
    super.key,
    required this.textName,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        border: BoxBorder.all(
          width: 1,
          color: Theme.of(context).highlightColor,
        ),
      ),
      child: ListTile(
        leading: Text(
          textName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        trailing: iconName,
      ),
    );
  }
}
