import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/constants/networking/app_constants.dart';
import 'package:news_app_practice/core/futures/routing/app_routes.dart';
import 'package:news_app_practice/core/futures/styling/app_styles.dart';
import 'package:news_app_practice/core/screens/home_screen/models/articles_model.dart';
import 'package:news_app_practice/core/screens/home_screen/repo/home_repo.dart';
import 'package:news_app_practice/core/screens/home_screen/widgets/articals_card_widget.dart';
import 'package:news_app_practice/core/screens/home_screen/widgets/costom_categoty_item_widget.dart';
import 'package:news_app_practice/core/screens/home_screen/widgets/top_headlines_item_widget.dart';
import 'package:news_app_practice/core/screens/serch_result_screen/services/serch_screen_serviecs.dart';
import 'package:news_app_practice/core/screens/serch_result_screen/widget/serch_text_fiald_widget.dart';
import 'package:news_app_practice/core/widget/spacing_widgets.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

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
              AppConstants.lang = context.locale.languageCode;
            },
            icon: Icon(Icons.language),
          ),
        ],
      ),

      body: FutureBuilder(
        future: SerchResultServices().serchItemByName(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData) {
            ArticlesModel topHeadlinesModel = snapshot.data as ArticlesModel;

            if (topHeadlinesModel.totalResults == 0) {
              return Center(child: Text('No_results'.tr()));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpace(16),

                // 🔹 Categories horizontal list

                // 🔹 Top headline item

                // 🔹 Articles list
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: ListView.builder(
                      itemCount: topHeadlinesModel.articles?.length ?? 0,
                      itemBuilder: (context, index) {
                        final article = topHeadlinesModel.articles![index];
                        return ArticalsCardWidget(articles: article);
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
