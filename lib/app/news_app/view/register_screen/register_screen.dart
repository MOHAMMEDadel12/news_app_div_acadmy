import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/app/news_app/control/auth_cubit/auth_cubit.dart';
import 'package:news_app/app/news_app/control/auth_cubit/auth_states.dart';
import 'package:news_app/app/news_app/view/login_screen/login_screen.dart';
import 'package:news_app/core/helpers/app_validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey,
                        child: AuthCubit.get(context).selectedImage != null
                            ? Image.file(
                                AuthCubit.get(context).selectedImage!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.person, size: 50),
                      ),
                      IconButton(onPressed: () {

                        ImagePicker().pickImage(source: ImageSource.camera).then((value) {
                          print("image is selected");
                          setState(() {
                            AuthCubit.get(context).selectedImage = File(value!.path);
                          });
                         print("image is selected ${value!.path}");
                        });
                        
                      
                      }, icon: const Icon(Icons.camera))
                    ],
                  ),
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
                        AuthCubit.get(context).registerWithFirebase(selectedImage: AuthCubit.get(context).selectedImage!);
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

