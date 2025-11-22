import 'package:flutter/material.dart';

import '../config/colors.dart';

/// Arrow Icon widget with accessibility support
class ArrowIcon extends StatelessWidget {
  final double padding;
  final double margin;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final IconData icon;
  final String? semanticLabel;
  final bool excludeSemantics;

  const ArrowIcon({
    this.padding = 4.0,
    this.margin = 4.0,
    this.iconSize = 18.0,
    this.iconColor = ColorsSet.grayDark,
    this.backgroundColor = ColorsSet.grayLighter,
    this.icon = Icons.arrow_forward_ios_rounded,
    this.semanticLabel,
    this.excludeSemantics = true,
    Key? key,
  }) : super(key: key);

  String _getDefaultSemanticLabel() {
    if (icon == Icons.arrow_forward_ios_rounded ||
        icon == Icons.arrow_forward_ios) {
      return 'Navigate forward';
    } else if (icon == Icons.arrow_back_ios_rounded ||
        icon == Icons.arrow_back_ios) {
      return 'Navigate back';
    }
    return 'Navigation icon';
  }

  @override
  Widget build(BuildContext context) {
    final iconWidget = Container(
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

    // Arrow icons are usually decorative when inside buttons
    // But can have semantic labels when standalone
    if (excludeSemantics) {
      return ExcludeSemantics(child: iconWidget);
    }

    return Semantics(
      label: semanticLabel ?? _getDefaultSemanticLabel(),
      image: true,
      child: iconWidget,
    );
  }
}
