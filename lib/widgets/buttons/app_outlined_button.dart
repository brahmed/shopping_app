import 'package:flutter/material.dart';

/// App Outlined Button custom widget with full accessibility support
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
  final bool enabled;
  final String? semanticLabel;
  final String? semanticHint;

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
    this.enabled = true,
    this.semanticLabel,
    this.semanticHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? text,
      hint: semanticHint ?? 'Double tap to activate',
      button: true,
      enabled: enabled,
      child: GestureDetector(
        onTap: enabled ? onClick : null,
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: padding),
          margin: EdgeInsets.symmetric(horizontal: margin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              width: borderWidth,
              color: enabled
                  ? (outlineColor ?? Theme.of(context).iconTheme.color!)
                  : Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: centerContent
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null)
                ExcludeSemantics(
                  child: icon!,
                ),
              if (icon != null) const SizedBox(width: 8),
              Flexible(
                child: Text(
                  text,
                  textAlign: centerContent ? TextAlign.center : TextAlign.start,
                  style: textStyle ??
                      TextStyle(
                        color: enabled
                            ? Theme.of(context).iconTheme.color
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
