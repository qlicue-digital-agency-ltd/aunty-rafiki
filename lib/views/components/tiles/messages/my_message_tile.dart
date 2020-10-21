import 'package:aunty_rafiki/models/message.dart';
import 'package:aunty_rafiki/views/components/cards/message/no_media.dart';
import 'package:flutter/material.dart';

class MyMessageTile extends StatelessWidget {
  final Message message;

  const MyMessageTile({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 24),
      alignment: Alignment.centerRight,
      child: Container(
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              color: Colors.white),
          child: NoMedia(
            message: message,
          )),
    );
  }
}

/////////////////
///
// import 'package:aunty_rafiki/models/message.dart';
// import 'package:aunty_rafiki/views/components/cards/message/double_media.dart';
// import 'package:aunty_rafiki/views/components/cards/message/no_media.dart';
// import 'package:aunty_rafiki/views/components/cards/message/quardripple_media.dart';
// import 'package:aunty_rafiki/views/components/cards/message/single_media.dart';
// import 'package:aunty_rafiki/views/components/cards/message/tripple_media.dart';
// import 'package:flutter/material.dart';

// class MyMessageTile extends StatelessWidget {
//   final Message message;

//   const MyMessageTile({Key key, @required this.message}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 24),
//       alignment: Alignment.centerRight,
//       child: Container(
//         margin: EdgeInsets.only(left: 10),
//         padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//                 bottomLeft: Radius.circular(15)),
//             color: Colors.white),
//         child: message.media == null
//             ? NoMedia(message: message)
//             : message.media.length == 1
//                 ? SingleMedia(
//                     message: message,
//                   )
//                 : message.media.length == 2
//                     ? DoubleMedia(message: message)
//                     : message.media.length == 3
//                         ? TrippleMedia(message: message)
//                         : QuardrippleMedia(
//                             message: message,
//                           ),
//       ),
//     );
//   }
// }
