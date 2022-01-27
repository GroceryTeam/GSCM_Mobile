import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final request = MyRequest().request;

class MyRequest {
  late Dio _inner;

  MyRequest() {
    BaseOptions options = BaseOptions(
      baseUrl: '',
      contentType: 'application/json',
    );
    _inner = Dio(options);
    _inner.interceptors.add(CustomInterceptors());
  }

  Dio get request => _inner;
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}