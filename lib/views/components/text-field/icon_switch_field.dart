import 'package:flutter/material.dart';

typedef IconSwitchFieldFunction = Function(bool);

class IconSwitchField extends StatelessWidget {
  final IconData icon;
  final IconSwitchFieldFunction onChanged;
  final bool syncToCalendar;
  const IconSwitchField(
      {Key key,
      @required this.icon,
      @required this.onChanged,
      @required this.syncToCalendar})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
              child: ListTile(
            title: Text('Sync to Calendar'),
            trailing: Switch(value: syncToCalendar, onChanged: onChanged),
          )),
        ],
      ),
    );
  }
}
