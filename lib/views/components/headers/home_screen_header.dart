import 'package:flutter/material.dart';

class HomeScreenHeader extends StatelessWidget {
  final String title;

  const HomeScreenHeader({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: size.height * 0.03, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
