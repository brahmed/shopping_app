import 'package:flutter/material.dart';

/// Helper function that displays a given content inside a Modal bottom sheet

Future<void> showAppBottomSheet({
  required BuildContext context,
  required Widget widget,
}) =>
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40),),
            color: Theme.of(context).backgroundColor,
          ),
          child: widget,
        );
      },
    );
