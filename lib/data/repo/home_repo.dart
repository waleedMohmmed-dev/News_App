import 'dart:developer';

import 'package:news_app_practice/core/constants/constants.dart';
import 'package:news_app_practice/core/networking/api_endpoints.dart';
import 'package:news_app_practice/core/networking/dio_helper.dart';
import 'package:news_app_practice/data/models/top_headlines_model.dart';

class HomeRepo {
  getTopHeadlineArticle() async {
    try {
      final response = await DioHelper.getRequest(
        endPoint: ApiEndpoints.topHeadlinesEndpoint,
        query: {"apiKey": AppConstants.newsApiKey, "country": "us"},
      );
      if (response.statusCode == 200) {
        ArticalModel topHeadLinesModel = ArticalModel.fromJson(response.data);
        log(topHeadLinesModel.totalResults.toString());
        return topHeadLinesModel;
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
