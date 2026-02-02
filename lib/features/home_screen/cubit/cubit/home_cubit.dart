import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_practice/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app_practice/features/home_screen/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomeRepo homeRepo = HomeRepo();

  Future<void> fetchTopHeadlines() async {
    emit(LoadingTopHeadlines());
    try {
      final response = await homeRepo.getTopHeadlineArticle();
      emit(SuccessTopHeadlines(response));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
