import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final bool isEditing;
  final TextEditingController textEditingController;
  final Function onTap;
  final Function(String) validator;
  final Function onEdit;
  final FocusNode focusNode;
  final TextInputType textInputType;
  final String suffix;
  const IconTextField(
      {Key key,
      @required this.icon,
      @required this.textEditingController,
      this.onTap,
      this.validator,
      @required this.title,
      this.focusNode,
      this.textInputType = TextInputType.text,
      this.suffix = '',
      this.isEditing = true,
      @required this.content,
      @required this.onEdit})
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
                child: isEditing
                    ? TextFormField(
                        focusNode: focusNode,
                        validator: validator,
                        keyboardType: textInputType,
                        onTap: onTap,
                        controller: textEditingController,
                        decoration: InputDecoration(
                            labelText: title,
                            border: InputBorder.none,
                            suffix: Text(suffix)),
                      )
                    : Text(content),
              ),
              content != null
                  ? IconButton(
                      color: Colors.pink,
                      icon: Icon(isEditing ? Icons.save : Icons.edit),
                      onPressed: onEdit)
                  : Container()
            ],
          ),
        ),
        content != null
            ? Divider(
                indent: 50,
                color: Colors.pink,
              )
            : Divider(
                indent: 50,
              ),
      ],
    );
  }
}
