import 'dart:developer';

import 'package:news_app_practice/core/constants/networking/api_endpoints.dart'
    show ApiEndpoints;
import 'package:news_app_practice/core/constants/networking/app_constants.dart';
import 'package:news_app_practice/core/constants/networking/dio_helper.dart';
import 'package:news_app_practice/core/screens/home_screen/models/articles_model.dart';

class HomeRepo {
  getTopHeadlinesArticles() async {
    try {
      final response = await DioHelper.getRequest(
        endPiont: ApiEndpoints.topHeadlines,
        query: {'apiKey': AppConstants.newsApiKey, 'country': 'us'},
      );
      if (response.statusCode == 200) {
        ArticlesModel topHeadlinesModel = ArticlesModel.fromJson(response.data);
        log(topHeadlinesModel.totalResults.toString());
        return topHeadlinesModel;
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
