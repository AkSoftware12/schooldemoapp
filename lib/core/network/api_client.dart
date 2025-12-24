import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;
  ApiClient(this.dio);

  Future<Response> post(String url, {dynamic data}) async {
    return await dio.post(url, data: data);
  }
}
