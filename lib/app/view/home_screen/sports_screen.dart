import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/control/home_cubit/home_cubit.dart';
import 'package:news_app/app/control/home_cubit/home_states.dart';
import 'package:news_app/app/view/widgets/news_item_widget.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({super.key});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {



initState(){
  HomeCubit.get(context).getNewsByCategory(category: "sports");
  super.initState();
} 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {

        if(state is HomeGetSportsNewsErrorState){
          print(state.error.message);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error.message ) , backgroundColor: Colors.red,));
        }

      },
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(

          itemBuilder: (context, index) => NewsItemWidget(news: HomeCubit.get(context).sportsNews[index],),
          separatorBuilder: (context, index) => const SizedBox(height: 40,),
          itemCount: HomeCubit.get(context).sportsNews.length,
        ),
      ),
    ) ;
  }
}
