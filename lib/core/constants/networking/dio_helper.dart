import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app_practice/core/constants/networking/api_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio; // ? instance of Dio

  ///true.

  static intiDio() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    //? interceptors
    dio!.interceptors.add(PrettyDioLogger());
  }

  static getRequest({
    required String endPiont,
    required Map<String, dynamic> query,
  }) async {
    try {
      Response response = await dio!.get(endPiont, queryParameters: query);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
