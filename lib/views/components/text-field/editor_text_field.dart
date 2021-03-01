import 'package:flutter/material.dart';

class EditorTextField extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController textEditingController;
  final Function onTap;
  final Function(bool) onEditTap;
  final Function(String) validator;
  final FocusNode focusNode;
  final TextInputType textInputType;
  final bool onEdit;
  const EditorTextField(
      {Key key,
      @required this.icon,
      @required this.textEditingController,
      @required this.onTap,
      @required this.validator,
      @required this.title,
      @required this.onEditTap,
      @required this.focusNode,
      this.textInputType = TextInputType.text,
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
              Column(
                children: [
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
                ],
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
                  enabled: onEdit,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: onEdit ? "" : title,
                    border: InputBorder.none,
                  ),
                ),
              ),

              IconButton(
                  icon: Icon(onEdit ? Icons.save : Icons.edit),
                  onPressed: () => onEditTap(!onEdit))
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
