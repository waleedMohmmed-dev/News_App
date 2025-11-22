import 'package:news_app_practice/core/screens/home_screen/models/articles_model.dart';

abstract class SearchState {}

class SerchInitialState extends SearchState {}

class SerchLodingState extends SearchState {}

class SucsessSearchState extends SearchState {
  final ArticlesModel articlesModel;

  SucsessSearchState(this.articlesModel);
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState(this.error);
}
