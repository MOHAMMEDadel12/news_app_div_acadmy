import 'package:flutter/material.dart';
import 'package:news_app/app/control/auth_cubit/auth_cubit.dart';
import 'package:news_app/app/view/home_screen/home_layout.dart';
import 'package:news_app/app/view/register_screen/register_screen.dart';
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
        child: Form(
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
                obscureText: true,
                validator: (value)=>AppValidators.validatePassword(value!),
               
               
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (AuthCubit.get(context).formKeyLogin.currentState!.validate()) {
                    AuthCubit.get(context).login().then((value) {
                     
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeLayout()));
                      
                    });

                    
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
        ),
      ),
    );
  }
}
