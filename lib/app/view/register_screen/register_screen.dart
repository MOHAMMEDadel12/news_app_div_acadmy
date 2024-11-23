import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/control/auth_cubit/auth_cubit.dart';
import 'package:news_app/app/control/auth_cubit/auth_states.dart';
import 'package:news_app/app/view/login_screen/login_screen.dart';
import 'package:news_app/core/helpers/app_validators.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: AuthCubit.get(context).formKeyRegister,
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const LoginScreen()));
              }
              if (state is RegisterErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error.message)));
              } 

          
            },
            builder: (context, state) {
              return Column(
                children: [
                TextFormField(
                  controller: AuthCubit.get(context).nameController,
                  
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => AppValidators.validateName(value!)  ,
                ),
                TextFormField(
                  controller: AuthCubit.get(context).phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) => AppValidators.validatePhone(value!),
                ),
                TextFormField(
                  controller: AuthCubit.get(context).emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => AppValidators.validateEmail(value!),
                  
                ),
                TextFormField(
                  controller: AuthCubit.get(context).passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => AppValidators.validatePassword(value!),
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthCubit, AuthStates>(
                  builder: (context, state) {

                    if (state is RegisterLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else {  
                      return ElevatedButton(
                        onPressed: () {
                      if (AuthCubit.get(context).formKeyRegister.currentState!.validate()) {
                        AuthCubit.get(context).register();
                      }
                    },
                    child: const Text('Register'),
                  );
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text("Already have an account? Login"),
                ),
              ],
              );
            },
          ),
        ),
      ),
    );
  }
}

