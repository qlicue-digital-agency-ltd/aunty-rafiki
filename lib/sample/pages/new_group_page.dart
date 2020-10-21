import 'package:flutter/material.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Group')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(flex: 2),
            Text('Type the name of the new group:'),
            TextField(
              controller: _controller,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 80),
                Expanded(
                  child: FlatButton(
                    shape: StadiumBorder(),
                    color: Theme.of(context).primaryColorLight,
                    child: Text('Create Group'),
                    onPressed: () {
                      Navigator.of(context).pop(_controller.text);
                    },
                  ),
                ),
                SizedBox(width: 80),
              ],
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
