import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/chat_app/view/user_chats_screen.dart';
import 'package:news_app/app/news_app/control/auth_cubit/auth_cubit.dart';
import 'package:news_app/app/news_app/control/auth_cubit/auth_states.dart';
import 'package:news_app/app/news_app/view/home_screen/home_layout.dart';
import 'package:news_app/app/news_app/view/register_screen/register_screen.dart';
import 'package:news_app/core/helpers/app_validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthCubit,AuthStates>(
          listener: (context,state){
            if(state is LoginSuccessState){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserChatsScreen()));
            }


            if(state is LoginErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error.message)));
            }
          },
          builder: (context,state){
            return Form(
              key: AuthCubit.get(context).formKeyLogin,
            child: Column(
              children: [
                TextFormField(
                  controller: AuthCubit.get(context).emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => AppValidators.validateEmail(value!),
                ),
                TextFormField(
                  controller: AuthCubit.get(context).passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: false,
                  validator: (value)=>AppValidators.validatePassword(value!),
                 
                 
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (AuthCubit.get(context).formKeyLogin.currentState!.validate()) {
                      AuthCubit.get(context).loginWithFirebase();
                      
                    }
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                  },
                  child: const Text("Don't have an account? Register"),
                ),
              ],
              ),
            );
          },
        ),
      ),
    );
  }
}
