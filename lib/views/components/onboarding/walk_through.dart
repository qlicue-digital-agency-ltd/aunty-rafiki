import 'package:flutter/material.dart';

class Walkthrougth extends StatelessWidget {
  final String title;
  final String textContent;
  final String icon;
  Walkthrougth(
      {Key key,
      @required this.textContent,
      @required this.title,
      @required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
       SizedBox(height: size.height * 0.15),
        Image.asset(icon,
        height: size.height * 0.12,
        ),
         SizedBox(height: size.height * 0.08,),
        Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 25),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                textContent,
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
      ],
    );
  }
}
