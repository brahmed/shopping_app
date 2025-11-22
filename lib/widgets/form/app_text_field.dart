import 'package:flutter/material.dart';

/// App Form Text Field custom widget with full accessibility support
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? label;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final String? semanticLabel;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const AppTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.semanticLabel,
    this.validator,
    this.enabled = true,
    this.textInputAction,
    this.onFieldSubmitted,
  }) : super(key: key);

  String _getSemanticLabel() {
    if (semanticLabel != null) return semanticLabel!;
    if (label is Text) {
      final textWidget = label as Text;
      return textWidget.data ?? hintText ?? 'Text field';
    }
    return hintText ?? 'Text field';
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _getSemanticLabel(),
      hint: obscureText
          ? 'Secure text entry'
          : 'Type to enter ${_getSemanticLabel().toLowerCase()}',
      textField: true,
      enabled: enabled,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        obscureText: obscureText,
        minLines: maxLines,
        maxLines: obscureText ? 1 : maxLines,
        enabled: enabled,
        validator: validator,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          label: label ?? const Text(""),
          hintText: hintText ?? "",
          // Add accessibility hints for errors
          errorMaxLines: 3,
        ),
      ),
    );
  }
}
