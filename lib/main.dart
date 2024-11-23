import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/control/auth_cubit/auth_cubit.dart';
import 'package:news_app/app/control/home_cubit/home_cubit.dart';
import 'package:news_app/app/view/home_screen/home_layout.dart';
import 'package:news_app/app/view/register_screen/register_screen.dart';
import 'package:news_app/core/netowk/dio_helper.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  RegisterScreen(),
      ),
    );
  }
}


