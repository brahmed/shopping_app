import 'package:flutter/material.dart';

/// App Outlined Button custom widget
class AppButtonOutlined extends StatelessWidget {
  final double height;
  final double width;
  final double borderWidth;
  final double padding;
  final double margin;
  final double radius;
  final Color? outlineColor;
  final Widget? icon;
  final bool centerContent;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onClick;

  const AppButtonOutlined({
    Key? key,
    this.height = 50.0,
    this.width = double.infinity,
    this.borderWidth = 2.0,
    this.padding = 12.0,
    this.margin = 0,
    this.radius = 8.0,
    this.outlineColor,
    this.icon,
    this.centerContent = false,
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
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            width: borderWidth,
            color: outlineColor ?? Theme.of(context).iconTheme.color!,
          ),
        ),
        child: Row(
          mainAxisAlignment: centerContent
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null) const SizedBox(width: 2),
            Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: Theme.of(context).iconTheme.color,
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
