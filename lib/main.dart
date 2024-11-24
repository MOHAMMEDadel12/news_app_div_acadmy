import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/chat_app/control/chat_cubit/chat_cubit.dart';
import 'package:news_app/app/chat_app/view/user_chats_screen.dart';
import 'package:news_app/app/news_app/control/auth_cubit/auth_cubit.dart';
import 'package:news_app/app/news_app/control/home_cubit/home_cubit.dart';
import 'package:news_app/app/news_app/view/register_screen/register_screen.dart';
import 'package:news_app/core/local/cashe_helper.dart';
import 'package:news_app/core/netowk/dio_helper.dart';
import 'package:news_app/core/utils/observer.dart';
import 'package:news_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.init();
  await CasheHelper.init();
  String? token = CasheHelper.getUserToken();
  runApp(MyApp(token: token!));
}

class MyApp extends StatelessWidget {
  final String ? token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: token == null ? RegisterScreen() : UserChatsScreen(),
      ),
    );
  }
}


