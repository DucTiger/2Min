import 'package:flutter/material.dart';
import 'package:two_min/config/constant.dart';

import '../../../config/colors.dart';
import 'default_dialog.dart';

class BaseDialogInfo extends StatelessWidget {
  final Widget? title;
  final Widget? message;
  final List<Widget>? actionsButton;

  const BaseDialogInfo({
    Key? key,
    required this.title,
    this.message,
    required this.actionsButton,
  })  : assert(actionsButton != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: kTypographyDarkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
              child: title!,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: kDefaultPadding),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: kTypographyLightGrey,
                      fontWeight: FontWeight.normal,
                    ),
                child: message!,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 40),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(child: actionsButton!.first),
                if (actionsButton!.length >= 2) ...[
                  const SizedBox(width: 15),
                  Flexible(child: actionsButton!.last),
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}
