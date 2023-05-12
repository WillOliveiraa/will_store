abstract class HttpClient {
  Future<Object> get(String url);
  Future<Object> post(String url, dynamic body);
}
