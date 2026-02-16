import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/constants/constants.dart';
import 'package:news_app_practice/core/styling/app_styles.dart';
import 'package:news_app_practice/core/widgets/spacing_widgets.dart';
import 'package:news_app_practice/data/models/top_headlines_model.dart';
import 'package:news_app_practice/presention/home_screen/widgets/article_card_widget.dart';
import 'package:news_app_practice/presention/screens/serch_result_screen/widget/serch_text_fiald_widget.dart';

import '../../../data/services/serch_serviecs.dart';

class SearchScreen extends StatelessWidget {
  final String? query;
  final ArticalModel? articles;

  const SearchScreen({super.key, this.query, this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('search_Result'.tr(), style: AppStyles.blacks14w700),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale(Locale('ar'));
              } else {
                context.setLocale(Locale('en'));
              }
              // eroor
              AppConstants.language = context.locale.languageCode;
            },
            icon: Icon(Icons.language),
          ),
        ],
      ),

      body: FutureBuilder(
        future: SerchResultServices().serchItemByName(query ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.blue));
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData) {
            ArticalModel topHeadlinesModel = snapshot.data as ArticalModel;

            if (topHeadlinesModel.totalResults == 0) {
              return Center(child: Text('No_results'.tr()));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpace(16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: ListView.builder(
                      itemCount: topHeadlinesModel.articles?.length ?? 0,
                      itemBuilder: (context, index) {
                        final article = topHeadlinesModel.articles![index];
                        return ArticleCardWidget(
                          title: article.title ?? '',
                          authorName: article.author ?? 'Unknown Author',
                          date: article.publishedAt?.toIso8601String().split('T').first ?? '',
                          imageUrl: article.urlToImage,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(child: Text('No Data'));
        },
      ),
    );
  }
}
