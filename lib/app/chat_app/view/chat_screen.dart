import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Mohamed Ahmed"),
      ),
      body: Column(

        children: [

          /// chat 
          Expanded(child: ListView.builder(
            itemBuilder: (context, index) {
              return Text("message");
            },
          )),
          




          /// text field send message
          TextField(
            
            decoration: InputDecoration(
              hintText: "Type a message",
            ),
          ),
        ],
      ),
    );
  }
}
