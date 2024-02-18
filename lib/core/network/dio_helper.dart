import 'dart:async';
import 'package:dio/dio.dart';
import 'package:interview_test/core/errors/exception.dart';
import 'package:interview_test/core/network/api_strings.dart';

import 'network_interface.dart';

class DioHelper implements BaseNetwork {
  final Dio dio;
  DioHelper({required this.dio});
  @override
  Future get(String endPoint) async {
    try {
      final response = await dio.get(ApiStrings.baseUrl + endPoint);

      return response.data;
    } on DioException catch (e) {
      handleDioErrors(e);
    }
  }

  handleDioErrors(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout) {
      throw AppTimeoutException(
        endPointUrl: err.requestOptions.path,
        statusCode: err.response!.statusCode!,
        message: err.message!,
      );
    }
    throw SereverException(
      endPointUrl: err.requestOptions.path,
      error: err.response?.data,
      message: err.message!,
      statusCode: err.response!.statusCode!,
    );
  }

  @override
  Future delete(String endPoint) {
    throw UnimplementedError();
  }

  @override
  Future post(String endPoint) {
    throw UnimplementedError();
  }

  @override
  Future update(String endPoint) {
    throw UnimplementedError();
  }
}
