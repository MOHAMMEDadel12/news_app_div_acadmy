import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/news_app/control/home_cubit/home_cubit.dart';
import 'package:news_app/app/news_app/control/home_cubit/home_states.dart';
import 'package:news_app/app/news_app/view/home_screen/sports_screen.dart';

class HomeLayout extends StatelessWidget {

  HomeLayout({super.key});



  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){

        return Scaffold(
        appBar: AppBar(
          title: Text('News App'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
        body: HomeCubit.get(context).screens[HomeCubit.get(context).selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          currentIndex: HomeCubit.get(context).selectedIndex,
          onTap: (value) {
      
            HomeCubit.get(context).changeIndexNavBar(value);
         
          },
          items: const [
           BottomNavigationBarItem(
              icon: Icon(Icons.sports),
              label: 'Sports',
            ),
           BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
           BottomNavigationBarItem(
              icon: Icon(Icons.science),
              label: 'Science',
            ),
         
          ],
        ),
      );
      },
    );
        
      
      
  
  }
}
