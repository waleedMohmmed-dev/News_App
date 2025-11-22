import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_practice/core/screens/serch_result_screen/cubit/search_state.dart';
import 'package:news_app_practice/core/screens/serch_result_screen/search_repo/serch_Repo.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SerchInitialState());
  final SerchResultRepo serchResultRepo = SerchResultRepo();
  Future<void> getSerchResultArticlas() async {
    emit(SerchLodingState());
    try {
      final response = await serchResultRepo.serchItemByName();
      emit(SucsessSearchState(response));
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }
}
