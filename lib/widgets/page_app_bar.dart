import 'package:flutter/material.dart';

import '../widgets/arrow_icon.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PageAppBar({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(title, style: Theme.of(context).textTheme.headline1),
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const ArrowIcon(
          icon: Icons.arrow_back_ios_rounded,
          margin: 12,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
