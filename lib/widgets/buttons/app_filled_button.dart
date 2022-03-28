import 'package:flutter/material.dart';

/// App Filled Button custom widget
class AppButtonFilled extends StatelessWidget {
  final double height;
  final double width;
  final double padding;
  final double margin;
  final double radius;
  final Color? fillColor;
  final Widget? icon;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onClick;

  const AppButtonFilled({
    Key? key,
    this.height = 50.0,
    this.width = double.infinity,
    this.padding = 12.0,
    this.margin = 0,
    this.radius = 8.0,
    this.fillColor,
    this.icon,
    this.text = "",
    this.textStyle,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: padding),
        margin: EdgeInsets.symmetric(horizontal: margin),
        decoration: BoxDecoration(
          color: fillColor ?? Theme.of(context).iconTheme.color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null) const SizedBox(width: 2),
            Text(
              text,
              style: textStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
