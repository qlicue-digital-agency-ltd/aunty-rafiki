import 'package:flutter/material.dart';

typedef IconTextFieldFunction = Function(String);
typedef IconTextFieldOnTap = Function();

class IconTextField extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController textEditingController;
  final IconTextFieldOnTap onTap;
  final IconTextFieldFunction validator;
  final FocusNode focusNode;
  final TextInputType textInputType;
  const IconTextField(
      {Key key,
      @required this.icon,
      @required this.textEditingController,
      this.onTap,
      this.validator,
      @required this.title,
      this.focusNode,
      this.textInputType = TextInputType.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  validator: validator,
                  keyboardType: textInputType,
                  onTap: onTap,
                  controller: textEditingController,
                  decoration: InputDecoration(
                      labelText: title, border: InputBorder.none),
                ),
              ),

              // ///For Text
              // Text(
              //   "Friday 28, November",
              //   style: TextStyle(
              //       fontSize: 18,
              //       height: 1.2,
              //       fontWeight: FontWeight.w700,
              //       color: Colors.grey[700]),
              // )
            ],
          ),
        ),
        Divider(
          indent: 50,
        ),
      ],
    );
  }
}
