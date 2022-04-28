import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/images.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset(
            emptyShelfImage,
          ),
        ),
      ),
    );
  }
}
