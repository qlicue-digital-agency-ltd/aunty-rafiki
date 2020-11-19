import 'package:flutter/material.dart';

class ColorLetterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Container for cat button
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.orangeAccent),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              "A",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 24),
            ),
          ),
        ),

        ///More buttons

        ///ForSpace
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
