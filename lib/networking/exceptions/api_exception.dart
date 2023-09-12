import 'dart:io';

import 'package:two_min/networking/exceptions/standard_error.dart';
import 'package:dio/dio.dart';

class ApiException {
  int? errorCode;
  String? errorMessage = "";
  DioError? exception;

  ApiException({required DioError exception}) {
    switch (exception.type) {
      case DioErrorType.response:
        dynamic errorBody = exception.response!.data;
        try {
          // try to parse to standard error
          StandardError standardError = StandardError.fromJson(errorBody['error']);
          errorMessage = standardError.message;
          errorCode = standardError.errorCode;
        } catch (e) {
          errorMessage = e.toString();

          // Try to get Dio internal error which might due to service not available
          if (exception.error != null) {
            errorMessage = exception.error.toString();
          }

          if (exception.response!.statusMessage != null &&
              exception.response!.statusMessage!.isNotEmpty) {
            errorMessage = exception.response!.statusMessage;
          }
        }
        break;
      default:
        switch (exception.type) {
          case DioErrorType.cancel:
            errorMessage = 'The connection is canceled. Please try again';
            break;
          case DioErrorType.connectTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.sendTimeout:
            errorMessage = 'The connection has timed out. Please try again';
            break;
          default:
            if (exception.error is SocketException ||
                exception.error is HttpException) {
              errorMessage =
                  'There are some problems with the connection. Please try again';
            } else {
              errorMessage =
                  'There are some problems with the connection and unknow exception type. Please try again';
            }
        }
    }
  }
}
