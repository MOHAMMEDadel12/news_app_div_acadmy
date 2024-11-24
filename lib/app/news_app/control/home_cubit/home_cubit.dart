import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/news_app/control/home_cubit/home_states.dart';
import 'package:news_app/app/news_app/view/home_screen/business_screen.dart';
import 'package:news_app/app/news_app/view/home_screen/scince_screen.dart';
import 'package:news_app/app/news_app/view/home_screen/sports_screen.dart';
import 'package:news_app/core/netowk/custom_exception.dart';
import 'package:news_app/core/netowk/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  List<Widget> screens = [
    const SportsScreen(),
    const BusinessScreen(),
    const ScienceScreen(),
  ];

  void changeIndexNavBar(int index) {
    selectedIndex = index;
    emit(HomeChangeIndexNavBarState());
  }

  List<dynamic> sportsNews = [];

  Future<void> getNewsByCategory({required String category}) async {
    emit(HomeGetSportsNewsLoadingState());

    try {
      final response = await DioHelper.getData(
        url: '/top-headlines/sources',
        queryParameters: {
          "category": category,
        },
      );

      sportsNews = response?.data["sources"]?.toList() ?? [];

      emit(HomeGetSportsNewsSuccessState());
    } on CustomException catch (error) {
      emit(HomeGetSportsNewsErrorState(error: error));
    } catch (e) {
      emit(HomeGetSportsNewsErrorState(error: CustomException(message: "some thing went wrong please try again")));
    }
  }
}
