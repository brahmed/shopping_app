import 'package:flutter/material.dart';

import 'gesture_text.dart';

/// This widget takes two string inputs
/// and redirect user when second string is clicked
class AuthRedirectionText extends StatelessWidget {
  final String staticText;
  final String clickableText;
  final String redirectionRouteName;

  const AuthRedirectionText({
    Key? key,
    required this.staticText,
    required this.clickableText,
    required this.redirectionRouteName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          staticText,
          textAlign: TextAlign.right,
          softWrap: false,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        GestureText(
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(redirectionRouteName),
          text: " $clickableText",
        ),
      ],
    );
  }
}
