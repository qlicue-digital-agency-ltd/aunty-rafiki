import 'package:flutter/material.dart';

typedef NoItemTileOnTap = Function();

class NoItemTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final double height;
  final double width;

  const NoItemTile({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    this.height = 400,
    this.width = 300,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      child: Column(
        children: <Widget>[
          Image.asset(icon, height: width / 3),
          SizedBox(height: 20,),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: width / 20),
              text: title,
              children: <TextSpan>[
                TextSpan(
                  text: '\n',
                ),
                TextSpan(
                  text: subtitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
