import 'package:flutter/material.dart';

typedef NoItemTileOnTap = Function();

class NoItemTile extends StatelessWidget {
  final String icon;
  final String title;
  final double height;
  final Function onTap;

  const NoItemTile({
    Key key,
    @required this.icon,
    @required this.title,
    this.height = 40,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(icon, height: height),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(title, textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }
}
