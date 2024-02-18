import 'dart:async';

import 'package:equatable/equatable.dart';

class BaseException extends Equatable implements Exception {
  final String message;
  final StackTrace? stackTrace;
  const BaseException(this.message, [this.stackTrace]);

  @override
  String toString() => message.toString();

  @override
  List<Object?> get props => [message, stackTrace];
}

class SereverException extends BaseException {
  final dynamic error;
  final int statusCode;
  final String endPointUrl;
  const SereverException({
    required String message,
    StackTrace? stackTrace,
    required this.error,
    required this.endPointUrl,
    required this.statusCode,
  }) : super(message, stackTrace);
  @override
  List<Object?> get props => [message, stackTrace, error, endPointUrl, statusCode];
}

class AppTimeoutException extends TimeoutException {
  final int statusCode;
  final String endPointUrl;

  AppTimeoutException({
    required this.endPointUrl,
    required String message,
    required this.statusCode,
  }) : super(message);
}
