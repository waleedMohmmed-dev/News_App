import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/routing/app_routes.dart';
import 'package:news_app_practice/core/styles/app_text_styles.dart';
import 'package:news_app_practice/core/widgets/spacing_widgets.dart';
import 'package:news_app_practice/busness_logic/cubit/cubit/home_cubit.dart';

import 'package:news_app_practice/data/models/top_headlines_model.dart';
import 'package:news_app_practice/data/repo/home_repo.dart';
import 'package:news_app_practice/presention/home_screen/widgets/article_card_widget.dart';
import 'package:news_app_practice/presention/home_screen/widgets/custom_category_item_widget.dart';
import 'package:news_app_practice/presention/home_screen/widgets/top_headline_item_widget.dart';
import 'package:news_app_practice/presention/screens/articals_details/articals_details_screen.dart';
import 'package:news_app_practice/presention/screens/serch_result_screen/search_screen.dart';
import 'package:news_app_practice/presention/screens/serch_result_screen/widget/serch_text_fiald_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().fetchTopHeadlines();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE9EEFA),
        toolbarHeight: 120.h,
        title: Text("explore".tr(), style: AppTextStyles.titlesStyles),
        actions: [SerchTextFialdWidget()],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is LoadingTopHeadlines) {
            return const Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is Error) {
            return Center(child: Text(state.errorMessage));
          } else if (state is SuccessTopHeadlines) {
            ArticalModel topHeadLinesModel = state.topHeadlines;

            return Column(
              children: [
                const HeightSpace(16),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 32.w),
                  child: SizedBox(
                    height: 40.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        CustomCategoryItemWidget(
                          title: "travel".tr(),
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).pushNamed(AppRoutes.searchScreen, extra: 'travel');
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "technology".tr(),
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).pushNamed(AppRoutes.searchScreen, extra: 'technology');
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "business".tr(),
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).pushNamed(AppRoutes.searchScreen, extra: 'business');
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "entertainment".tr(),
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).pushNamed(AppRoutes.searchScreen, extra: 'entertainment');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const HeightSpace(24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      TopHeadlineItemWidget(
                        imageUrl: topHeadLinesModel.articles![0].urlToImage,
                        // imageUrl:
                        //     "https://www.cnet.com/a/img/resize/bde1b8ca1b9373b61bbf9d3e113a81ac76297b51/hub/2024/09/13/0df30744-a33f-4c6e-b58c-a90d7a914089/apple-iphone-16-2815.jpg?auto=webp&height=500",
                        title: topHeadLinesModel.articles![0].title ?? "",
                        authorName: topHeadLinesModel.articles![0].author ?? "",
                        date: DateFormat(
                          'yyyy-MM-dd – kk:mm',
                        ).format(topHeadLinesModel.articles![0].publishedAt!),
                      ),
                    ],
                  ),
                ),
                const HeightSpace(24),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: ListView.builder(
                      itemCount: topHeadLinesModel.articles!.length,
                      itemBuilder: (context, index) {
                        Article article = topHeadLinesModel.articles![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchScreen(articles: topHeadLinesModel),
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticalsScreen(
                                    title: article.title ?? '',
                                    authorName: article.author ?? '',
                                    date:
                                        article.publishedAt
                                            ?.toIso8601String()
                                            .split('T')
                                            .first ??
                                        '',
                                    imageUrl: article.urlToImage,
                                  ),
                                ),
                              );
                            },
                            child: ArticleCardWidget(
                              title: article.title ?? '',
                              authorName: article.author ?? 'Unknown Author',
                              date:
                                  article.publishedAt?.toIso8601String().split('T').first ??
                                  '',
                              imageUrl: article.urlToImage,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
