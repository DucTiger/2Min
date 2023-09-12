import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'base_dialog_info.dart';

/// Need custom for each project
class DialogConfirmation extends StatelessWidget {
  final String? title;
  final String? message;
  final List<String>? actionsButton;
  final Function? onPositiveButtonPressed;
  final Function? onNegativeButtonPressed;

  const DialogConfirmation({
    Key? key,
    required this.title,
    this.message,
    required this.actionsButton,
    this.onPositiveButtonPressed,
    this.onNegativeButtonPressed,
  })  : assert(actionsButton != null && actionsButton.length == 2),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialogInfo(
      title: Text(title!),
      message: Text(message!),
      actionsButton: [
        ElevatedButton(
          onPressed: () {
            if (onPositiveButtonPressed != null) {
              onPositiveButtonPressed?.call();
              context.router.pop();
            }
          },
          child: Text(actionsButton!.first),
        ),
        ElevatedButton(
          onPressed: () {
            if (onNegativeButtonPressed != null) {
              onNegativeButtonPressed?.call();
              context.router.pop();
            }
          },
          child: Text(actionsButton!.last),
        )
      ],
    );
  }
}
