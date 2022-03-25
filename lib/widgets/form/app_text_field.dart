import 'package:flutter/material.dart';

/// App Form Text Field custom widget
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? label;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;

  const AppTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      minLines: maxLines,
      decoration: InputDecoration(
        label: label ?? const Text(""),
        hintText: hintText ?? "",
      ),
    );
  }
}
