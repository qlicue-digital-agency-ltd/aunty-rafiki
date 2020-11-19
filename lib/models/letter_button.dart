import 'package:flutter/material.dart';

class LetterButton {
  final int id;
  String letter;
  String tittle;

  bool isSelected;

  LetterButton(
      {@required this.id,
      @required this.letter,
      @required this.tittle,
      @required this.isSelected});
}

List<LetterButton> letteButtonLists = <LetterButton>[
  LetterButton(id: 1, letter: "A", isSelected: true, tittle: 'All'),
  LetterButton(id: 2, letter: "C", isSelected: false, tittle: 'Clinic'),
  LetterButton(id: 3, letter: "S", isSelected: false, tittle: 'Suppliments'),
  LetterButton(id: 4, letter: "D", isSelected: false, tittle: 'Diet'),
  LetterButton(id: 5, letter: "O", isSelected: false, tittle: 'Others'),
];
