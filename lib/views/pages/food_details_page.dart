import 'package:flutter/material.dart';

class FoodDetailsPage extends StatelessWidget {
  final String title;

  const FoodDetailsPage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          
        ],
      )),
    );
  }
}
