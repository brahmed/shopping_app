import 'package:flutter/material.dart';

import '../../config/colors.dart';

class ArrowIcon extends StatelessWidget {
  final double padding;
  final double margin;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final IconData icon;

  const ArrowIcon({
    this.padding = 4.0,
    this.margin = 4.0,
    this.iconSize = 18.0,
    this.iconColor = ColorsSet.grayDark,
    this.backgroundColor = ColorsSet.grayLighter,
    this.icon = Icons.arrow_forward_ios_rounded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
