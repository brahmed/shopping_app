import 'package:flutter/material.dart';

/// App Filled Button custom widget with full accessibility support
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
  final bool enabled;
  final String? semanticLabel;
  final String? semanticHint;

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
            color: enabled
                ? (fillColor ?? Theme.of(context).iconTheme.color)
                : Colors.grey,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      TextStyle(
                        color: enabled ? Colors.white : Colors.white70,
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
