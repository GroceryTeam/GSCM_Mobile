import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class MyRequest {
  late Dio _inner;

  MyRequest() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://grocerycloudstoreownerapi2.azurewebsites.net/api/v1.0/',
      headers: {
        Headers.contentTypeHeader: 'application/json',
      }
    );
    _inner = Dio(options);
    _inner.interceptors.add(CustomInterceptors());
  }

  Dio get request => _inner;

  void setBearerToken(String token) {
    _inner.options.headers['Authorization'] = 'Bearer $token';
  }
}

final myRequest = MyRequest();
final request = myRequest.request;

class WrongUsernamePasswordException implements Exception {
  String message = 'Tên tài khoản hoặc mật khẩu không đúng';
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