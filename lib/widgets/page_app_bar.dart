import 'package:flutter/material.dart';

import 'arrow_icon.dart';

/// Page AppBar with full accessibility support
class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const PageAppBar({
    required this.title,
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: '$title page',
      child: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Semantics(
          label: title,
          header: true,
          child: Text(title, style: Theme.of(context).textTheme.headlineLarge),
        ),
        leading: Semantics(
          label: 'Back',
          hint: 'Double tap to go back',
          button: true,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const ArrowIcon(
              icon: Icons.arrow_back_ios_rounded,
              margin: 12,
              excludeSemantics: true,
            ),
          ),
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
