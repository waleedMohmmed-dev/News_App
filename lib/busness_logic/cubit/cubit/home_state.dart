part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingTopHeadlines extends HomeState {}

final class SuccessTopHeadlines extends HomeState {
  final ArticalModel topHeadlines;
  SuccessTopHeadlines(this.topHeadlines);
}

final class Error extends HomeState {
  final String errorMessage;
  Error(this.errorMessage);
}
