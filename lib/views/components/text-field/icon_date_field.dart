import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

typedef IconDateFieldFunction = Function(String);

class IconDateField extends StatelessWidget {
  final TextEditingController textEditingController;
  final IconDateFieldFunction onChage;
  final IconDateFieldFunction onValidate;
  final IconDateFieldFunction onSaved;
  final IconData icon;
  final DateTimePickerType type;
  final String title;
  final String dateMask;
  final DateTime firstDate;
  final DateTime lastDate;

  const IconDateField(
      {Key key,
      @required this.textEditingController,
      @required this.onChage,
      @required this.onValidate,
      @required this.onSaved,
      @required this.icon,
      @required this.type,
      @required this.title,
      this.dateMask,
      this.firstDate,
      this.lastDate})
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

              ///For Text
              Expanded(
                child: DateTimePicker(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  type: type,
                  dateMask: dateMask,
                  controller: textEditingController,
                  timeLabelText: title,
                  onChanged: onChage,
                  validator: onValidate,
                  onSaved: onSaved,
                  firstDate: firstDate,
                  lastDate: lastDate,
                ),
              ),
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
