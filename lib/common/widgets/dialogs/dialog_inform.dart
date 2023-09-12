import 'package:two_min/common/widgets/dialogs/base_dialog_info.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:two_min/utils/typo_style.dart';

import '../buttons/primary_button.dart';

/// Need custom for each project
class DialogInform extends StatelessWidget {
  final String? title;
  final String? message;
  final String? actionsButton;
  final Function? onPressed;

  const DialogInform({
    Key? key,
    required this.title,
    required this.message,
    required this.actionsButton,
    this.onPressed,
  })  : assert(actionsButton != null),
        assert(title != null),
        assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialogInfo(
      title: Text(title!),
      message: Text(message!),
      actionsButton: [
        PrimaryButton(
          isWrapContent: true,
          onPressed: () {
            if (onPressed != null) {
              onPressed?.call();
              context.router.pop();
            }
          },
          title: actionsButton,
        ),
      ],
    );
  }
}
