import 'package:flutter/material.dart';

class IconSelectorField extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;

  const IconSelectorField(
      {Key key,
      @required this.title,
      @required this.onTap,
      @required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey[100],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ///Container for Icon
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(255, 240, 240, 1)),
              padding: const EdgeInsets.all(16),
              child: Icon(
                icon,
                color: Colors.redAccent,
              ),
            ),

            ///For spacing
            SizedBox(
              width: 24,
            ),

            ///For Text
            Text(
              title,
            ),

            Spacer(),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: onTap,
            )
          ],
        ),
      ),
    );
  }
}
