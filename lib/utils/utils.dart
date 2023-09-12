import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Utils {
  static String enumToString(Object? object) =>
      object.toString().split('.').last;

  static T? enumFromString<T>(String? key, Iterable<T> values) =>
      values.firstWhereOrNull((v) => key == enumToString(v));

  static void afterBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static void showSnackBarMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
