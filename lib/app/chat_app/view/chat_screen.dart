import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/chat_app/control/chat_cubit/chat_cubit.dart';
import 'package:news_app/app/news_app/control/auth_cubit/auth_cubit.dart';
import 'package:news_app/core/local/cashe_helper.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String otherUserId;
  const ChatScreen({super.key, required this.name, required this.otherUserId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    String currentUserId = CasheHelper.getUserToken()!;
    super.initState();
    ChatCubit.get(context).createChat(
        currentUserId: currentUserId, otherUserId: widget.otherUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            /// chat

            StreamBuilder<QuerySnapshot>(
              stream: ChatCubit.get(context).getMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Expanded(
                        child: Center(child: Text("NO Chats Found")));
                  } else {
                    return Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) =>
                          Align(
                              alignment: snapshot.data!.docs[index]["senderId"] !=
                                      widget.otherUserId
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Card(
                            color: snapshot.data!.docs[index]["senderId"] !=
                                    widget.otherUserId
                                ? Colors.blue
                                : Colors.grey,
                            
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data!.docs[index]["message"],
                                  style: TextStyle(
                                      color: snapshot.data!.docs[index]["senderId"] !=
                                              widget.otherUserId
                                          ? Colors.white
                                          : Colors.black,
                                  )),
                            ),
                          )),
                      itemCount: snapshot.data!.docs.length,
                    ));
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),

            /// text field send message
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ChatCubit.get(context).messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      ChatCubit.get(context).sendMessage(
                          message:
                              ChatCubit.get(context).messageController.text);

                      /// send message
                      ///
                      ///
                      ChatCubit.get(context).messageController.clear();
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
