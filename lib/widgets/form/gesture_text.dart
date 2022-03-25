import 'package:flutter/material.dart';

/// A Text Widget that handles user clicks
class GestureText extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final TextStyle? textStyle;

  const GestureText({
    Key? key,
    required this.onTap,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.right,
        softWrap: false,
        style: textStyle ??
            theme.textTheme.bodyText1?.copyWith(color: theme.iconTheme.color),
      ),
    );
  }
}
