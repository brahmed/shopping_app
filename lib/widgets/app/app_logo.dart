import 'package:flutter/material.dart';

import '../../config/images.dart';

/// App Logo Image Asset Widget
class AppLogo extends StatelessWidget {
  final double scale;
  final double height;

  const AppLogo({
    Key? key,
    this.scale = 1.0,
    this.height = 200.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      appImage,
      height: height,
      scale: scale,
      color: Theme.of(context).iconTheme.color,
    );
  }
}
