import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:news_app_practice/core/screens/home_screen/cubit/cubit_states.dart';
import 'package:news_app_practice/core/screens/home_screen/repo/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  final HomeRepo homeRepo = HomeRepo();

  Future<void> getTopHeeadLinesArticals() async {
    emit(LodingTopHeadlinesState());
    try {
      final response = await homeRepo.getTopHeadlinesArticles();
      emit(SuccessTopHeadlinesState(response));
    } catch (e) {
      emit(ErrorTopHeadlinesState(e.toString()));
    }
  }
}
