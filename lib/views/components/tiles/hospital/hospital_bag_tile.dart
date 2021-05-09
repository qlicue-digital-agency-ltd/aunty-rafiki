import 'package:flutter/material.dart';

class HospitalBagTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;

  const HospitalBagTile(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.icon,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(255, 240, 240, 1)),
            padding: const EdgeInsets.all(16),
            child: Icon(
              icon,
              color: Colors.redAccent,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
        ),
        Divider(indent: 70)
      ],
    );
  }
}
