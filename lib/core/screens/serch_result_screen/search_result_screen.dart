import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/constants/networking/app_constants.dart';
import 'package:news_app_practice/core/futures/routing/app_routes.dart';
import 'package:news_app_practice/core/futures/styling/app_styles.dart';
import 'package:news_app_practice/core/screens/home_screen/models/articles_model.dart';
import 'package:news_app_practice/core/screens/home_screen/repo/home_repo.dart';
import 'package:news_app_practice/core/screens/home_screen/widgets/articals_card_widget.dart';
import 'package:news_app_practice/core/screens/home_screen/widgets/costom_categoty_item_widget.dart';
import 'package:news_app_practice/core/screens/home_screen/widgets/top_headlines_item_widget.dart';
import 'package:news_app_practice/core/screens/serch_result_screen/cubit/search_cubit.dart';
import 'package:news_app_practice/core/screens/serch_result_screen/cubit/search_state.dart';
import 'package:news_app_practice/core/screens/serch_result_screen/search_repo/serch_Repo.dart';

import 'package:news_app_practice/core/screens/serch_result_screen/widget/serch_text_fiald_widget.dart';
import 'package:news_app_practice/core/widget/spacing_widgets.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    context.read<SearchCubit>().getSerchResultArticlas();
    super.initState();
  }

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

      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (State is SerchLodingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (State is SearchErrorState) {
            Center(child: Text(State.error.toString()));
          } else if (State is SucsessSearchState) {
            ArticlesModel articlesModel = State.articlesModel as ArticlesModel;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpace(16),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: ListView.builder(
                      itemCount: articlesModel.topHeadlinesModel?.length ?? 0,
                      itemBuilder: (context, index) {
                        final article = articlesModel.topHeadlinesModel![index];
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
