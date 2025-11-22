import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app_practice/core/constants/networking/api_endpoints.dart'
    show ApiEndpoints;
import 'package:news_app_practice/core/constants/networking/app_constants.dart';
import 'package:news_app_practice/core/constants/networking/dio_helper.dart';
import 'package:news_app_practice/core/screens/home_screen/models/articles_model.dart';

class SerchResultRepo {
  serchItemByName() async {
    try {
      final response = await DioHelper.getRequest(
        endPiont: ApiEndpoints.searchEndpoint,
        query: {
          'apiKey': AppConstants.newsApiKey,

          'language': AppConstants.lang,
        },
      );
      if (response.statusCode == 200) {
        ArticlesModel articlesModel = ArticlesModel.fromJson(response.data);
        log(articlesModel.totalResults.toString());
        return articlesModel;
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
