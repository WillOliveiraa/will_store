import 'dart:io';

import 'package:dio/dio.dart';
import 'package:will_store/freight/infra/http/http_client.dart';
import 'package:will_store/utils/utils/constant.dart';

class DioAdapter implements HttpClient {
  late Dio _dio;

  DioAdapter({Dio? dio}) {
    _dio = dio ?? Dio();
    _dio.options.headers[HttpHeaders.authorizationHeader] = tokenCepStr;
  }
  @override
  Future<Map<String, dynamic>> get(String url) async {
    final response = await _dio.get(url);
    if (response.statusCode == 422) throw ArgumentError(response.statusMessage);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> post(String url, body) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
