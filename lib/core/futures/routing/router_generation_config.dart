import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/futures/routing/app_routes.dart';
import 'package:news_app_practice/core/screens/articals_details/articals_details_screen.dart';
import 'package:news_app_practice/core/screens/home_screen/cubit/home_cubit.dart';
import 'package:news_app_practice/core/screens/home_screen/home_screen.dart';
import 'package:news_app_practice/core/screens/home_screen/models/articles_model.dart';
import 'package:news_app_practice/core/screens/serch_result_screen/cubit/search_cubit.dart';
import 'package:news_app_practice/core/screens/serch_result_screen/search_result_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.homeScreen,
    routes: [
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) =>
            BlocProvider(create: (context) => HomeCubit(), child: HomeScreen()),
      ),

      GoRoute(
        path: AppRoutes.searchScreen,
        name: AppRoutes.searchScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => SearchCubit(),
          child: SearchResultScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.articalDetailsScreen,
        name: AppRoutes.articalDetailsScreen,
        builder: (context, state) {
          Articles articles = state.extra as Articles;
          return ArticalsDetailsScreen(articles: articles);
        },
      ),
    ],
  );
}
