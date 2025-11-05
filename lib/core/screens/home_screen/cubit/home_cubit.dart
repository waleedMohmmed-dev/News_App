import 'package:bloc/bloc.dart';
import 'package:news_app_practice/core/screens/home_screen/cubit/cubit_states.dart';
import 'package:news_app_practice/core/screens/home_screen/repo/home_repo.dart';

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitialState());

//   final HomeRepo homeRepo = HomeRepo(); // ? instance of repo
//   Future<void> getTobHeadLines() async {
//     emit(LodingTopHeadlinesState());
//     try {
//       final response = await homeRepo.getTopHeadlinesArticles();
//       emit(SuccessTopHeadlinesState(response));
//     } catch (e) {
//       emit(ErrorTopHeadlinesState(e.toString()));
//     }
//   }
// }
