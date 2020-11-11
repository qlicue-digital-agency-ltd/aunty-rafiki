// import 'package:aunty_rafiki/models/message.dart';
// import 'package:aunty_rafiki/views/pages/media_preview_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class QuardrippleMedia extends StatelessWidget {
//   final Message message;
//   final double _imageHeight = 150;
//   const QuardrippleMedia({Key key, @required this.message}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width * 0.7,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 2),
//               Row(children: [
//                 Expanded(
//                     child: InkWell(
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => MediaPreviewListPage(
//                                 media: message.media,
//                               ))),
//                   child: Hero(
//                     tag: message.media[0].url,
//                     child: Image.asset(
//                       message.media[0].url,
//                       height: _imageHeight,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 )),
//                 SizedBox(width: 2),
//                 Expanded(
//                     child: InkWell(
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => MediaPreviewListPage(
//                                 media: message.media,
//                               ))),
//                   child: Hero(
//                     tag: message.media[1].url,
//                     child: Image.asset(
//                       message.media[1].url,
//                       height: _imageHeight,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 )),
//               ]),
//               SizedBox(height: 2),
//               Row(children: [
//                 Expanded(
//                     child: InkWell(
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => MediaPreviewListPage(
//                                 media: message.media,
//                               ))),
//                   child: Hero(
//                     tag: message.media[2].url,
//                     child: Image.asset(
//                       message.media[2].url,
//                       height: _imageHeight,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 )),
//                 SizedBox(width: 2),
//                 Expanded(
//                     child: Stack(
//                   children: [
//                     InkWell(
//                       onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => MediaPreviewListPage(
//                                     media: message.media,
//                                   ))),
//                       child: Hero(
//                         tag: message.media[3].url,
//                         child: Container(
//                           height: _imageHeight,
//                           decoration: BoxDecoration(
//                               // boxShadow: [BoxShadow(color: Colors.black38)],
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(
//                                     message.media[3].url,
//                                   ))),
//                         ),
//                       ),
//                     ),
//                     message.media.length > 4
//                         ? InkWell(
//                             onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => MediaPreviewListPage(
//                                           media: message.media,
//                                         ))),
//                             child: Container(
//                               height: _imageHeight,
//                               color: Colors.black38,
//                               child: Center(
//                                 child: Text(
//                                   '+' + (message.media.length - 4).toString(),
//                                   style: TextStyle(
//                                       fontSize: 30,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           )
//                         : Container(),
//                   ],
//                 )),
//               ]),
//               message.text != null
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 5),
//                         Text(message.text,
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontFamily: 'OverpassRegular',
//                                 fontWeight: FontWeight.w300)),
//                         SizedBox(height: 5),
//                       ],
//                     )
//                   : Container(
//                       width: 0,
//                       height: 10,
//                     ),
//             ],
//           ),
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
