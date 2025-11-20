import 'package:flutter/material.dart';

class GestureTextRiverpod extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GestureTextRiverpod({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
