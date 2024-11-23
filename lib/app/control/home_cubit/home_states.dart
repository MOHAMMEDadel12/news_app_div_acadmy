import 'package:news_app/core/netowk/custom_exception.dart';
import 'package:news_app/core/netowk/dio_helper.dart';

class HomeStates {}

class HomeInitialState extends HomeStates{}

class HomeChangeIndexNavBarState extends HomeStates{}

class HomeGetSportsNewsLoadingState extends HomeStates{}

class HomeGetSportsNewsSuccessState extends HomeStates{}

class HomeGetSportsNewsErrorState extends HomeStates{

  final CustomException error;

  HomeGetSportsNewsErrorState({required this.error});


}

