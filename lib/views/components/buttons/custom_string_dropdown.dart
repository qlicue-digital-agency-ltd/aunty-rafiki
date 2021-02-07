import 'package:flutter/material.dart';

typedef CustomStringDropdownButtonOnChange = Function(String);

class CustomStringDropdown extends StatelessWidget {
  final CustomStringDropdownButtonOnChange onChange;
  final String title;
  final String value;
  final List<String> items;
  final bool isRequired;

  const CustomStringDropdown(
      {Key key,
      @required this.value,
      @required this.items,
      @required this.onChange,
      @required this.title,
      this.isRequired = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 240, 240, 1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: EdgeInsets.only(left: 5),
        height: 60,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: title),
                  TextSpan(
                      text: isRequired ? ' *' : '',
                      style: TextStyle(fontSize: 18, color: Colors.red))
                ], style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ),
            Expanded(
              flex: 1,
              child: DropdownButton(
                isExpanded: true,
                hint: Text(
                  '--- Select ' + title + '---',
                  overflow: TextOverflow.ellipsis,
                ),
                iconSize: 35,
                value: value,
                iconDisabledColor: Colors.grey,
                iconEnabledColor: Theme.of(context).primaryColor,
                items: items.map((val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
                onChanged: (newValue) => onChange(newValue),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
