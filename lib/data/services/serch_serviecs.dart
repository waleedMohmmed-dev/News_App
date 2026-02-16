import 'dart:developer';

import 'package:news_app_practice/core/constants/constants.dart';
import 'package:news_app_practice/core/networking/api_endpoints.dart';
import 'package:news_app_practice/core/networking/dio_helper.dart';
import 'package:news_app_practice/data/models/top_headlines_model.dart';

class SerchResultServices {
  serchItemByName(String query) async {
    try {
      final response = await DioHelper.getRequest(
        endPoint: ApiEndpoints.searchEndpoint,

        query: {
          'apiKey': AppConstants.newsApiKey,
          'q': query,
          'language': AppConstants.language,
        },
      );
      if (response.statusCode == 200) {
        ArticalModel articlesModel = ArticalModel.fromJson(response.data);
        log(articlesModel.totalResults.toString());
        return articlesModel;
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
