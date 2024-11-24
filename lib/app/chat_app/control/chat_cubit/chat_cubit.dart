import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/chat_app/control/chat_cubit/chat_states.dart';
import 'package:news_app/app/chat_app/model/user_model.dart';
import 'package:news_app/app/news_app/control/auth_cubit/auth_states.dart';
import 'package:news_app/core/local/cashe_helper.dart';
import 'package:news_app/core/netowk/custom_exception.dart';
import 'package:news_app/core/netowk/dio_helper.dart';
import 'package:news_app/core/netowk/end_points_keys.dart';

/// auth
/// cloud firestore  and realtime database
/// storage

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];




  getAllUsers() async {
    emit(GetAllUsersLoadingState());
    users.clear();

    
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("users").get();


    for (var element in querySnapshot.docs) {

      String token = await CasheHelper.getUserToken() ?? "";
      print("toooooooken ${token}");
      if (element.id == token) {
        continue;
      } else {
        users.add(UserModel.fromJson(element.data() as Map<String, dynamic>));

      }
    }

    emit(GetAllUsersSuccessState());

  }
}
