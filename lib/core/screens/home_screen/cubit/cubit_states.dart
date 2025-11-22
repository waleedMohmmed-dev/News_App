import 'package:news_app_practice/core/screens/home_screen/models/articles_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class LodingTopHeadlinesState extends HomeState {}

class SuccessTopHeadlinesState extends HomeState {
  final ArticlesModel topHeadlinesModel;

  SuccessTopHeadlinesState(this.topHeadlinesModel);
}

class ErrorTopHeadlinesState extends HomeState {
  final String error;

  ErrorTopHeadlinesState(this.error);
}
