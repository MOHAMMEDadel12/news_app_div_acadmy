import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/chat_app/control/chat_cubit/chat_cubit.dart';
import 'package:news_app/app/chat_app/control/chat_cubit/chat_states.dart';
import 'package:news_app/app/chat_app/view/login_screen/login_screen.dart';
import 'package:news_app/app/chat_app/view/register_screen/register_screen.dart';
import 'package:news_app/core/local/cashe_helper.dart';

class UserChatsScreen extends StatefulWidget {
  const UserChatsScreen({super.key});

  @override
  State<UserChatsScreen> createState() => _UserChatsScreenState();
}

class _UserChatsScreenState extends State<UserChatsScreen> {

 


  @override
  void initState()  {
    ChatCubit.get(context).getAllUsers();
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),

      //
      //
      

        actions: [
          IconButton(onPressed: (){
            CasheHelper.clearSharedPreferences();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
          }, icon: Icon(Icons.logout , color: Colors.red,))
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatStates>(
        builder: (context, state) {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10,),
          itemCount: ChatCubit.get(context).users.length,
          itemBuilder: (context, index) {
            return  Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    "https://via.placeholder.com/150",
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  children: [
                    Text(ChatCubit.get(context).users[index].name!),
                    Text(ChatCubit.get(context).users[index].email!),
                  ],
                ),
              ],
            );
          },
          );
        },
      ),
    );
  }
}
