import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget {
  final Widget? child;

  const DefaultDialog({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: child,
    );
  }
}
