import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Auth Redirection Text widget with full accessibility support
class AuthRedirectionTextRiverpod extends StatelessWidget {
  final String staticText;
  final String clickableText;
  final String redirectionRoute;
  final String? semanticLabel;

  const AuthRedirectionTextRiverpod({
    Key? key,
    required this.staticText,
    required this.clickableText,
    required this.redirectionRoute,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Semantics(
            excludeSemantics: true,
            child: Text(staticText),
          ),
          const SizedBox(width: 5),
          Semantics(
            label: semanticLabel ?? clickableText,
            hint: 'Double tap to $clickableText',
            link: true,
            button: true,
            child: GestureDetector(
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
          ),
        ],
      ),
    );
  }
}
