import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tr_store_demo/core/error/exceptions.dart';

class ReturnResponse<T> {
  T call(Response<dynamic> response, Function(dynamic) fromJsonFunc) {
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      log("response ${response.data}");
      return fromJsonFunc(response.data) as T;
    } else {
      throw ServerException();
    }
  }
}
