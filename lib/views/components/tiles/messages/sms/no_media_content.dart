import 'package:aunty_rafiki/models/message.dart';
import 'package:aunty_rafiki/providers/group_provider.dart';
import 'package:aunty_rafiki/views/pages/private_chat_room_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoMediaContent extends StatelessWidget {
  final Message message;
  final bool byMe;

  const NoMediaContent({Key key, @required this.message, @required this.byMe})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final formatter = new DateFormat('HH:mm');
    final _groupProvider = Provider.of<GroupProvider>(context);

    Future<void> _showMyDialog({@required Message message}) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    leading: Icon(Icons.message, color: Colors.pink),
                    title: Text('Message ${message.senderName}'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Send'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivateChatRoomPage(
                                peer: _groupProvider.currentGroupMembers
                                    .where((user) => user.uid == message.sender)
                                    .first,
                              )));
                },
              ),
            ],
          );
        },
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print('-------------------');
            _showMyDialog(message: message);
          },
          child: Container(
              constraints: BoxConstraints(maxWidth: width - 80),
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 4,
              ),
              child: RichText(
                  text: TextSpan(
                      text: byMe ? "" : '${message.senderName}\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: message.text,
                        style: TextStyle(color: Colors.black45, fontSize: 15))
                  ]))),
        ),
        Container(
          padding: const EdgeInsets.only(right: 4, bottom: 2),
          child: Text(
            '${formatter.format(message.time)}',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
