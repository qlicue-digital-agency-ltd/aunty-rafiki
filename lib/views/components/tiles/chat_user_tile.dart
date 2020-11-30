import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:aunty_rafiki/sample/model/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatUserTile extends StatelessWidget {
  final Chat chat;
  final Function onTap;

  const ChatUserTile({Key key, @required this.chat, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: chat.avatar == null
                        ? NetworkImage(chat.avatar)
                        : AssetImage('assets/icons/female.png'),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(chat.name),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            chat.lastMessage,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _utilityProvider.formatDate(DateTime.parse(chat.time)),
              style: TextStyle(
                  fontSize: 12,
                  color:
                      chat.isMessageRead ? Colors.pink : Colors.grey.shade500),
            ),
          ],
        ),

        //  Row(children: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child: CircleAvatar(
        //       radius: 35,
        //       backgroundImage: chat.avatar == null
        //           ? NetworkImage(chat.avatar)
        //           : AssetImage('assets/icons/female.png'),
        //     ),
        //   ),
        //   Expanded(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Expanded(
        //           child: Row(children: <Widget>[
        //             Expanded(
        //               child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: <Widget>[
        //                     Text(
        //                       chat.name,
        //                       style: TextStyle(
        //                           fontWeight: FontWeight.bold, fontSize: 18),
        //                     ),
        //                     Text('chat.messages.last.text')
        //                   ]),
        //             ),
        //             Expanded(
        //               child: Padding(
        //                 padding: const EdgeInsets.only(right: 10),
        //                 child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.end,
        //                     children: <Widget>[
        //                       // chat.unreadMessageCounter > 0
        //                       //     ? CircleAvatar(
        //                       //         radius: 12,
        //                       //         backgroundColor:
        //                       //             Theme.of(context).primaryColor,
        //                       //         child: Text(
        //                       //           chat.unreadMessageCounter.toString(),
        //                       //           style: TextStyle(
        //                       //               color: Colors.white, fontSize: 12),
        //                       //         ))
        //                       //     : Container()
        //                     ]),
        //               ),
        //             )
        //           ]),
        //         ),
        //         Divider()
        //       ],
        //     ),
        //   )
        // ]),
      ),
    );
  }
}
