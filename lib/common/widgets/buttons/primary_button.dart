import 'package:flutter/material.dart';
import 'package:two_min/config/colors.dart';
import 'package:two_min/config/constant.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final double? width;
  final double? height;
  final bool isWrapContent;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.width,
    this.height,
    this.isWrapContent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isWrapContent ? null : width ?? double.infinity,
      height: height ?? kDefaultButtonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
        onPressed: onPressed != null
            ? () {
                if (onPressed != null) {
                  onPressed!.call();
                }
              }
            : null,
        child: Text(
          title ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}
