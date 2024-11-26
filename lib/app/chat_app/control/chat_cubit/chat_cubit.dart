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

  TextEditingController messageController = TextEditingController();
  ScrollController listScrollController = ScrollController();

  static ChatCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];

  String chatId = "";

  getAllUsers() async {
    String token = await CasheHelper.getUserToken() ?? "";

    emit(GetAllUsersLoadingState());
    users.clear();

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("users").get();

    for (var doc in querySnapshot.docs) {
      if (doc.id == token) {
        continue;
      } else {
        users.add(
            UserModel.fromJson(doc.data() as Map<String, dynamic>, doc.id));
      }
    }

    print("users ${users.length}");

    emit(GetAllUsersSuccessState());
  }

  createChat(
      {required String currentUserId, required String otherUserId}) async {
    List<String> ids = [currentUserId, otherUserId];

    ids.sort();

    chatId = ids.join("-");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Chats").doc(chatId);

    documentReference.set({"data": "والله العظيم فيه داتا ولكن مش بيظهر "});

    print("chatIdddddddddd ${documentReference.id}");
  }

  sendMessage({required String message}) async {
    emit(SendMessageLoadingState());
    String userID = await CasheHelper.getUserToken() ?? "";

    await FirebaseFirestore.instance
        .collection("Chats")
        .doc(chatId)
        .collection("Messages")
        .doc()
        .set({
      "message": message,
      "time": DateTime.now(),
      "senderId": userID,
    });
    emit(SendMessageSuccessState());

  }

  Stream<QuerySnapshot> getMessages() {
    emit(GetMessagesLoadingState());

    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection("Chats")
        .doc(chatId)
        .collection("Messages")
        .orderBy("time", descending: false)
        .snapshots();

    emit(GetMessagesSuccessState());
    return stream;
  }
}
