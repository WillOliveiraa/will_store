import 'dart:io';

import 'package:dio/dio.dart';
import 'package:will_store/core/utils/constant.dart';
import 'package:will_store/freight/infra/http/http_client.dart';

class DioAdapter implements HttpClient {
  late Dio _dio;

  DioAdapter() {
    _dio = Dio();
    _dio.options.headers[HttpHeaders.authorizationHeader] = tokenCepStr;
  }
  @override
  Future<Object> get(String url) async {
    final response = await _dio.get(url);
    if (response.statusCode == 422) throw ArgumentError(response.statusMessage);
    return response.data;
  }

  @override
  Future<Object> post(String url, body) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
