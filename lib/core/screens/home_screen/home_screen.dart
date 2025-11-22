import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/constants/networking/app_constants.dart';
import 'package:news_app_practice/core/futures/routing/app_routes.dart';
import 'package:news_app_practice/core/futures/styling/app_styles.dart';
import 'package:news_app_practice/core/screens/home_screen/cubit/cubit_states.dart';
import 'package:news_app_practice/core/screens/home_screen/cubit/home_cubit.dart';
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
    context.read<HomeCubit>().getTopHeeadLinesArticals();
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
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, index) {
          if (State is LodingTopHeadlinesState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (State is ErrorTopHeadlinesState) {
            return Center(child: Text(State.error));
          } else if (State is SuccessTopHeadlinesState) {
            ArticlesModel topHeadlinesModel = State.topHeadlinesModel;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpace(16),

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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      TopHeadlinesItemWidget(
                        imageUrl:
                            topHeadlinesModel
                                .topHeadlinesModel![0]
                                .urlToImage ??
                            '',

                        title:
                            topHeadlinesModel.topHeadlinesModel![0].title ?? '',

                        autherName:
                            topHeadlinesModel.topHeadlinesModel![0].author ??
                            '',
                        date: DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(
                            topHeadlinesModel
                                    .topHeadlinesModel![0]
                                    .publishedAt ??
                                '',
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
                      itemCount:
                          topHeadlinesModel.topHeadlinesModel?.length ?? 0,
                      itemBuilder: (context, index) {
                        final article =
                            topHeadlinesModel.topHeadlinesModel![index];
                        return ArticalsCardWidget(articles: article);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        },
      ),
    );
  }
}
