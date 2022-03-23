import 'package:flutter/material.dart';

import '../config/colors.dart';

/// Custom Card container
class AppCard extends StatelessWidget {
  final Widget child;
  final double margin;
  final double padding;
  final double radius;
  final Color? color;
  final BoxShadow? boxShadow;

  const AppCard({
    required this.child,
    this.margin = 8.0,
    this.padding = 8.0,
    this.radius = 15,
    this.color,
    this.boxShadow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color ?? Theme.of(context).backgroundColor,
        boxShadow: [
          boxShadow ??
              BoxShadow(
                color: appShadowColor.withOpacity(0.3),
                blurRadius: 1.0, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset: const Offset(
                  1.0, // Move to right 10  horizontally
                  1.0, // Move to bottom 10 Vertically
                ),
              ),
        ],
      ),
      child: child,
    );
  }
}
