import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Image.asset(
      'assets/icons/aunty_rafiki.png',
      height: size.height * 0.12,
    );
  }
}
