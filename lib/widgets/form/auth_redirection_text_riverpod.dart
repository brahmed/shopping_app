import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthRedirectionTextRiverpod extends StatelessWidget {
  final String staticText;
  final String clickableText;
  final String redirectionRoute;

  const AuthRedirectionTextRiverpod({
    Key? key,
    required this.staticText,
    required this.clickableText,
    required this.redirectionRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(staticText),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => context.push(redirectionRoute),
          child: Text(
            clickableText,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
