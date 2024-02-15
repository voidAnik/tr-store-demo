import 'package:dio/dio.dart';

class ApiClient {
  static ApiClient? _instance;
  static ApiClient get instance {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = ApiClient.init();
      return _instance!;
    }
  }

  late final Dio dio;

  ApiClient.init() {
    dio = Dio(
      BaseOptions(baseUrl: 'https://www.jsonplaceholder.org'),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
      ),
    );
  }
}
