import 'package:aunty_rafiki/models/message.dart';
import 'package:aunty_rafiki/views/components/cards/message_card.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        leading: FlatButton(
            child: Row(children: <Widget>[
              Expanded(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text('1',
                      style: TextStyle(color: Colors.white, fontSize: 18)))
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
      body: ListView.builder(
          itemCount: messagePool.length,
          itemBuilder: (_, index) => MessageCard(
                message: messagePool[index],
              )),
    );
  }
}
