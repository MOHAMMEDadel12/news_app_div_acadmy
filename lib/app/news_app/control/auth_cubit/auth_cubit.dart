import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/news_app/control/auth_cubit/auth_states.dart';
import 'package:news_app/core/local/cashe_helper.dart';
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

   File   ? selectedImage ;

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

  clearControllers() {
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    nameController.clear();
  }

  loginWithFirebase() async {
    emit(LoginLoadingState());

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);


  print("sadasdasd ${credential.user!.uid}");

      CasheHelper.setUserToken(token: credential.user!.uid);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(
            CustomException(message: "No user found for that email.")));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(CustomException(
            message: "Wrong password provided for that user.")));
      }
    } catch (e) {
      emit(LoginErrorState(
          CustomException(message: "some thing went wrong please try again")));
    }
  }

  registerWithFirebase({required File selectedImage}) async {
    emit(RegisterLoadingState());

    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

    

      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set({
        "email": emailController.text,
        "name": nameController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
      });

      // FirebaseStorage.instance
      //     .ref()
      //     .child("users-images")
      //     .child("${credential.user!.uid}.png")
      //     .putFile(selectedImage)
      //     .then((value) {
      //   value.ref.getDownloadURL().then((value) {
      //     print("image is uploaded successfully ${value}");
      //   });
      // });

      emit(RegisterSuccessState());

      print(credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState(
            CustomException(message: "The password provided is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(CustomException(
            message: "The account already exists for that email.")));
      }
    } catch (e) {
      emit(RegisterErrorState(
          CustomException(message: "some thing went wrong please try again")));
    }
  }


updateLastSeen() async {
  await FirebaseFirestore.instance.collection("users").doc(CasheHelper.getUserToken()).update({"lastSeen": DateTime.now()});
}
}
