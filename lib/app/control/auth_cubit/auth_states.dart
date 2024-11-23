import 'package:news_app/core/netowk/custom_exception.dart';
import 'package:news_app/core/netowk/dio_helper.dart';

class AuthStates {}


/// Initial State
class AuthInitialState extends AuthStates{}



/// Login States
class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{}
class LoginErrorState extends AuthStates{
  final CustomException error;
  LoginErrorState(this.error);
}



/// Register States
class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{}
class RegisterErrorState extends AuthStates{
  final CustomException error;
  RegisterErrorState(this.error);
}

