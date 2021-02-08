import 'package:flutter/material.dart';

class LoaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/aunt_rafiki.png'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.pink[50].withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
    );
  }
}
