import 'package:flutter/material.dart';

import 'app_card.dart';
import 'arrow_icon.dart';

class AccountItemCard extends StatelessWidget {
  final double margin;
  final double padding;
  final double radius;
  final IconData? iconData;
  final double iconSize;
  final String text;

  const AccountItemCard({
    this.margin = 8.0,
    this.padding = 8.0,
    this.radius = 8.0,
    this.iconSize = 35,
    this.iconData,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: margin,
      padding: padding,
      radius: radius,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Icon
          if (iconData != null) Icon(iconData!, size: iconSize),

          /// spacing
          if (iconData != null) const SizedBox(width: 15),

          /// Title
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),

          const Expanded(child: SizedBox()),

          /// Arrow Icon
          const ArrowIcon(),
        ],
      ),
    );
  }
}
