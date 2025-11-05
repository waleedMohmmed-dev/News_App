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
import 'package:news_app_practice/core/screens/serch_result_screen/widget/serch_text_fiald_widget.dart';
import 'package:news_app_practice/core/widget/spacing_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Explore'.tr(), style: AppStyles.primaryHeadLinesStyle),
        backgroundColor: const Color(0xffE9EEFA),
        toolbarHeight: 88,
        // ! important
        actions: [
          SerchTextFialdWidget(),
          IconButton(
            onPressed: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale(const Locale('ar'));
              } else {
                context.setLocale(const Locale('en'));
              }
              AppConstants.lang = context.locale.languageCode;
            },
            icon: Icon(Icons.language),
          ),
        ],
      ),
      body: FutureBuilder(
        future: HomeRepo.getTopHeadlinesArticles(),
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
              return Center(child: Text('No results'.tr()));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpace(16),

                // 🔹 Categories horizontal list
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 32),
                  child: SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        CostomCategotyItemWidget(
                          title: 'Entertainment'.tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchScreen,
                              extra: 'Entertainment'.tr(),
                            );
                          },
                        ),
                        CostomCategotyItemWidget(
                          title: 'Technology'.tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchScreen,
                              extra: 'Technology'.tr(),
                            );
                          },
                        ),
                        CostomCategotyItemWidget(
                          title: 'Business'.tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchScreen,
                              extra: 'Business'.tr(),
                            );
                          },
                        ),
                        // ! important
                        CostomCategotyItemWidget(
                          title: 'Travel'.tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchScreen,
                              extra: 'Travel'.tr(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const HeightSpace(16),

                // 🔹 Top headline item
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      TopHeadlinesItemWidget(
                        imageUrl:
                            topHeadlinesModel.articles![0].urlToImage ?? '',
                        title: topHeadlinesModel.articles![0].title ?? '',
                        autherName: topHeadlinesModel.articles![0].author ?? '',
                        date: DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(
                            topHeadlinesModel.articles![0].publishedAt ?? '',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const HeightSpace(24),

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
