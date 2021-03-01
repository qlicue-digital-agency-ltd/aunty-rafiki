// import 'package:aunty_rafiki/models/message.dart';
// import 'package:aunty_rafiki/views/pages/media_preview_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class TrippleMedia extends StatelessWidget {
//   final Message message;

//   const TrippleMedia({Key key, @required this.message}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 6),
//             InkWell(
//               onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => MediaPreviewListPage(
//                            media: [
//                               message.media[0],
//                               message.media[1],
//                               message.media[2],
//                             ],
//                           ))),
//               child: Hero(
//                 tag: message.media[0].url,
//                 child: Image.asset(
//                   message.media[0].url,
//                   fit: BoxFit.cover,
//                   width: MediaQuery.of(context).size.width * 0.7,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             InkWell(
//               onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => MediaPreviewListPage(
//                             media: [
//                               message.media[0],
//                               message.media[1],
//                               message.media[2],
//                             ],
//                           ))),
//               child: Hero(
//                 tag: message.media[1].url,
//                 child: Image.asset(
//                   message.media[1].url,
//                   fit: BoxFit.cover,
//                   width: MediaQuery.of(context).size.width * 0.7,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             InkWell(
//               onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => MediaPreviewListPage(
//                              media: [
//                               message.media[0],
//                               message.media[1],
//                               message.media[2],
//                             ],
//                           ))),
//               child: Hero(
//                 tag: message.media[2].url,
//                 child: Image.asset(
//                   message.media[2].url,
//                   fit: BoxFit.cover,
//                   width: MediaQuery.of(context).size.width * 0.7,
//                 ),
//               ),
//             ),
//             message.text != null
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 5),
//                       Text(message.text,
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontFamily: 'OverpassRegular',
//                               fontWeight: FontWeight.w300)),
//                       SizedBox(height: 5),
//                     ],
//                   )
//                 : Container(
//                     width: 0,
//                     height: 10,
//                   ),
//           ],
//         ),
//         Positioned(
//           bottom: message.text != null ? 0 : 10,
//           right: 0,
//           child: Text(
//             DateFormat('Hm').format(message.date),
//             style: TextStyle(color: Colors.black38),
//             textAlign: TextAlign.end,
//           ),
//         )
//       ],
//     );
//   }
// }
