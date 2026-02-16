import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/routing/app_routes.dart';
import 'package:news_app_practice/busness_logic/cubit/cubit/home_cubit.dart';

import 'package:news_app_practice/presention/home_screen/home_screen.dart';
import 'package:news_app_practice/presention/screens/articals_details/articals_details_screen.dart';
import 'package:news_app_practice/presention/screens/serch_result_screen/search_screen.dart';

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
        builder: (context, state) {
          String query = state.extra as String;
          return SearchScreen(query: query);
        },
      ),
      GoRoute(
        path: AppRoutes.searchResultScreen,
        name: AppRoutes.searchResultScreen,
        builder: (context, state) => Container(),
      ),
      GoRoute(
        path: AppRoutes.articleDetailsScreen,
        name: AppRoutes.articleDetailsScreen,
        builder: (context, state) => ArticalsScreen(
          title: state.extra is ArticalsScreen ? (state.extra as ArticalsScreen).title : '',
          authorName: state.extra is ArticalsScreen
              ? (state.extra as ArticalsScreen).authorName
              : '',
          date: state.extra is ArticalsScreen ? (state.extra as ArticalsScreen).date : '',
          imageUrl: state.extra is ArticalsScreen
              ? (state.extra as ArticalsScreen).imageUrl
              : '',
        ),
      ),
    ],
  );
}
