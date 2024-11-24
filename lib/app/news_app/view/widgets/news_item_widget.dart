import 'package:flutter/material.dart';

class NewsItemWidget extends StatelessWidget {


  final dynamic news;
  const NewsItemWidget({super.key, required this.news});


  @override
  Widget build(BuildContext context) {
    return Container(
   
      child: Column(
          children: [
            Image.network(news["urlToImage"] ?? "https://www.imago-images.com/bild/sp/1053658368/w.jpg"),
          SizedBox(height: 10,),
          Text(news["description"]),
        ],
      ),
    );
  }
}
