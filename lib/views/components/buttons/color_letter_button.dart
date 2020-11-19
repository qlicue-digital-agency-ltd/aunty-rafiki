import 'package:aunty_rafiki/models/letter_button.dart';
import 'package:flutter/material.dart';

class ColorLetterButton extends StatelessWidget {
  final LetterButton letterButton;
  final Function onTap;

  const ColorLetterButton(
      {Key key, @required this.letterButton, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Container for cat button
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: letterButton.isSelected
                    ? Colors.orangeAccent
                    : Colors.grey[800]),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                letterButton.letter,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24),
              ),
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
