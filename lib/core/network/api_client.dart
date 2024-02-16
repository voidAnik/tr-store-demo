import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tr_store_demo/app/flavors.dart';

class ApiClient {
  late final Dio dio;

  ApiClient.init() {
    dio = Dio(
      BaseOptions(
        baseUrl: F.basUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
      ),
    );
  }
}
