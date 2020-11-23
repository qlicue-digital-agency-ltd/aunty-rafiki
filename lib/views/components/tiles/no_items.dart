import 'package:flutter/material.dart';

typedef NoItemTileOnTap = Function();

class NoItemTile extends StatelessWidget {
  final String icon;
  final String title;
  final double height;

  const NoItemTile({
    Key key,
    @required this.icon,
    @required this.title,
    this.height = 40,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(icon, height: height),
          Text(title),
        
        ],
      ),
    );
  }
}
