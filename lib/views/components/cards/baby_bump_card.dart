import 'package:flutter/material.dart';

class BabyBumpCard extends StatelessWidget {
  final String image;

  BabyBumpCard({@required this.image});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Image.asset(
        image,
        height: screenHeight,
        width: screenWidth,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
