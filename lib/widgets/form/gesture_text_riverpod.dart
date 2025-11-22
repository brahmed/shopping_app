import 'package:flutter/material.dart';

/// Gesture Text widget with full accessibility support
class GestureTextRiverpod extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String? semanticLabel;
  final String? semanticHint;

  const GestureTextRiverpod({
    Key? key,
    required this.text,
    required this.onTap,
    this.semanticLabel,
    this.semanticHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? text,
      hint: semanticHint ?? 'Double tap to activate',
      link: true,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
