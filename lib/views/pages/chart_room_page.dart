import 'package:flutter/material.dart';

class ChartRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            child: Row(children: <Widget>[
              Expanded(
                              child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20,),
              Expanded(child: Text('1', style: TextStyle(color: Colors.white, fontSize: 18)))
            ]),
            onPressed: () => Navigator.pop(context)),
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/a.jpg'),
          ),
          title: Text(
            'David',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
