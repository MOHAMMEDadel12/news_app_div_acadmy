import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/control/auth_cubit/auth_states.dart';
import 'package:news_app/core/netowk/custom_exception.dart';
import 'package:news_app/core/netowk/dio_helper.dart';
import 'package:news_app/core/netowk/end_points_keys.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  /// form keys
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();

  /// controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  login() async {
    emit(LoginLoadingState());

    Map<String, dynamic> loginData = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    try {
      var response = await DioHelper.postData(
        url: EndPointsKeys.login,
        data: loginData,
      );

      print(response?.data["userDetailsDto"]["token"]);



      emit(LoginSuccessState());
    } on CustomException catch (e) {
      emit(LoginErrorState(e));
    } catch (e) {
      emit(LoginErrorState(
          CustomException(message: "some thing went wrong please try again")));
    }
  }



clearControllers(){
  emailController.clear();
  passwordController.clear();
  phoneController.clear();
  nameController.clear();
}
  register() async {
    emit(RegisterLoadingState());

    FormData formData = FormData.fromMap({
      "Email": emailController.text,
      "Password": passwordController.text,
      "PhoneNumber": phoneController.text,
      "Name": nameController.text,
    });

    try {
      var response = await DioHelper.postData(
        url: EndPointsKeys.register,
        data: formData,
      );
      clearControllers();
      emit(RegisterSuccessState());
    } on CustomException catch (e) {
      emit(RegisterErrorState(e));
    } catch (e) {
      emit(RegisterErrorState(
          CustomException(message: "some thing went wrong please try again")));
    }
  }
}
