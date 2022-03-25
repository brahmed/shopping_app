import 'package:flutter/material.dart';

import '../widgets/cards/app_page_container.dart';

/// Helper function that displays a given content inside a Modal bottom sheet

Future<void> showAppBottomSheet({
  required BuildContext context,
  required Widget widget,
}) =>
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AppPageContainer(
          child: widget,
        );
      },
    );
