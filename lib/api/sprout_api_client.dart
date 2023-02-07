import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef AccessTokenProvider = Future<String?> Function();
typedef OnInvalidToken = void Function({Error error});

class ApiClient {
  ApiClient({
    required this.baseUrl,
    this.onInvalidToken,
  }) {
    dio = Dio()
      ..options.baseUrl = baseUrl
      ..interceptors.add(
        QueuedInterceptorsWrapper(
          onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
            options.headers = <String, dynamic>{
              'Accept': 'application/json',
              'content-type': 'application/json',
            };
            handler.next(options);
          },
          onError: (error, handler) {
            if (error.error is SocketException) {
              throw const UserException(
                'No internet connection',
                cause: 'No internet connection',
              );
            } else if (error.response?.statusCode == 401) {
              onInvalidToken?.call();
            }
            return handler.reject(error);
          },
        ),
      );
    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
    }
  }

  final String baseUrl;
  final OnInvalidToken? onInvalidToken;
  late Dio dio;
}
