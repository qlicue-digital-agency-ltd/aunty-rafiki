// import 'dart:async';
// import 'package:aunty_rafiki/models/message.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';

// class ChatScreenPage extends StatefulWidget {
//   @override
//   State createState() => new ChatScreenState();
// }

// class ChatScreenState extends State<ChatScreenPage> {
//   ChatScreenState({Key key});

//   var listMessage;

//   bool isLoading;
//   bool isShowSticker = false;

//   final TextEditingController textEditingController =
//       new TextEditingController();
//   final ScrollController listScrollController = new ScrollController();
//   final FocusNode focusNode = new FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(onFocusChange);

//     isLoading = false;
//     isShowSticker = false;
//   }

//   void onFocusChange() {
//     if (focusNode.hasFocus) {
//       // Hide sticker when keyboard appear
//       setState(() {
//         isShowSticker = false;
//       });
//     }
//   }

//   void getSticker() {
//     // Hide keyboard when sticker appear
//     focusNode.unfocus();
//     setState(() {
//       isShowSticker = !isShowSticker;
//     });
//   }

//   Widget buildItem(int index, Message document) {

//       // Right (my message)
//       return Row(
//         children: <Widget>[
//           document.image == 'plain-text'
//               // Text
//               ? Container(
//                   child: Text(
//                     document.text,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                   width: 200.0,
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor,
//                       borderRadius: BorderRadius.circular(8.0)),
//                   margin: EdgeInsets.only(
//                       bottom: isLastMessageRight(index) ? 20.0 : 10.0,
//                       right: 10.0),
//                 )
//               : document.type == 'image'
//                   // Image
//                   ? Container(
//                       child: Material(
//                         child: Image(
//                             height: 200,
//                             width: 200,
//                             fit: BoxFit.cover,
//                             image: AssetImage(document.image)),
//                         borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                         clipBehavior: Clip.hardEdge,
//                       ),
//                       margin: EdgeInsets.only(
//                           bottom: isLastMessageRight(index) ? 20.0 : 10.0,
//                           right: 10.0),
//                     )
//                   // Sticker
//                   : Container(
//                       child: new Image.asset(
//                         document.sticker,
//                         width: 100.0,
//                         height: 100.0,
//                         fit: BoxFit.cover,
//                       ),
//                       margin: EdgeInsets.only(
//                           bottom: isLastMessageRight(index) ? 20.0 : 10.0,
//                           right: 10.0),
//                     ),
//         ],
//         mainAxisAlignment: MainAxisAlignment.end,
//       );
//     } else {
//       // Left (peer message)
//       return Container(
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 isLastMessageLeft(index)
//                     ? Material(
//                         child: Image(
//                             height: 35.0,
//                             width: 35.0,
//                             fit: BoxFit.cover,
//                             image: AssetImage(document.image)),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(18.0),
//                         ),
//                         clipBehavior: Clip.hardEdge,
//                       )
//                     : Container(width: 35.0),
//                 document.type == 'plain-text'
//                     ? Container(
//                         child: Text(
//                           document.text,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                         width: 200.0,
//                         decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius: BorderRadius.circular(8.0)),
//                         margin: EdgeInsets.only(left: 10.0),
//                       )
//                     : document.type == 'image'
//                         ? Container(
//                             child: Material(
//                               child: Image(
//                                   height: 200,
//                                   width: 200,
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(document.image)),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8.0)),
//                               clipBehavior: Clip.hardEdge,
//                             ),
//                             margin: EdgeInsets.only(left: 10.0),
//                           )
//                         : Container(
//                             child: new Image.asset(
//                               document.sticker,
//                               width: 100.0,
//                               height: 100.0,
//                               fit: BoxFit.cover,
//                             ),
//                             margin: EdgeInsets.only(
//                                 bottom: isLastMessageRight(index) ? 20.0 : 10.0,
//                                 right: 10.0),
//                           ),
//               ],
//             ),

//             // Time
//             isLastMessageLeft(index)
//                 ? Container(
//                     child: Text(
//                       document.time,
//                       style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12.0,
//                           fontStyle: FontStyle.italic),
//                     ),
//                     margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
//                   )
//                 : Container()
//           ],
//           crossAxisAlignment: CrossAxisAlignment.start,
//         ),
//         margin: EdgeInsets.only(bottom: 10.0),
//       );
//     }
//   }

//   bool isLastMessageLeft(int index) {
//     if ((index > 0 && listMessage != null && listMessage[index - 1]) ||
//         index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   bool isLastMessageRight(int index) {
//     if ((index > 0 && listMessage != null && listMessage[index - 1]) ||
//         index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<bool> onBackPress() {
//     if (isShowSticker) {
//       setState(() {
//         isShowSticker = false;
//       });
//     } else {
//       Navigator.pop(context);
//     }

//     return Future.value(false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: new Text(
//           'CHAT',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: WillPopScope(
//         child: Stack(
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 // List of messages
//                 buildListMessage(),

//                 // Sticker
//                 (isShowSticker ? buildSticker() : Container()),

//                 // Input content
//                 buildInput(),
//               ],
//             ),

//             // Loading
//             buildLoading()
//           ],
//         ),
//         onWillPop: onBackPress,
//       ),
//     );
//   }

//   Widget buildSticker() {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               FlatButton(
//                 onPressed: () {
//                   // saveMessage(
//                   //     type: 2,
//                   //     sticker: 'assets/img/gif/mimi1.gif',
//                   //     image: 'assets/img/gabriel.jpeg',
//                   //     content: "mmhhh yesss",
//                   //     idFrom: 10,
//                   //     timestamp:
//                   //         DateTime.now().millisecondsSinceEpoch.toString());
//                 },
//                 child: new Image.asset(
//                   'assets/img/gif/mimi1.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () {
//                   // saveMessage(
//                   //     type: 2,
//                   //     sticker: 'assets/img/gif/mimi2.gif',
//                   //     image: 'assets/img/gabriel.jpeg',
//                   //     content: "mmhhh yesss",
//                   //     idFrom: 10,
//                   //     timestamp:
//                   //         DateTime.now().millisecondsSinceEpoch.toString());
//                 },
//                 child: new Image.asset(
//                   'assets/img/gif/mimi2.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () {
//                   // saveMessage(
//                   //       type: 2,
//                   //       sticker: 'assets/img/gif/mimi3.gif',
//                   //       image: 'assets/img/gabriel.jpeg',
//                   //       content: "mmhhh yesss",
//                   //       idFrom: 10,
//                   //       timestamp:
//                   //           DateTime.now().millisecondsSinceEpoch.toString());
//                 },
//                 child: new Image.asset(
//                   'assets/img/gif/mimi3.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               )
//             ],
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           ),
//           Row(
//             children: <Widget>[
//               FlatButton(
//                 onPressed: () {
//                   //  saveMessage(
//                   //       type: 2,
//                   //       sticker: 'assets/img/gif/mimi4.gif',
//                   //       image: 'assets/img/gabriel.jpeg',
//                   //       content: "mmhhh yesss",
//                   //       idFrom: 10,
//                   //       timestamp:
//                   //           DateTime.now().millisecondsSinceEpoch.toString());
//                 },
//                 child: new Image.asset(
//                   'assets/img/gif/mimi4.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () {
//                   // saveMessage(
//                   //     type: 2,
//                   //     sticker: 'assets/img/gif/mimi5.gif',
//                   //     image: 'assets/img/gabriel.jpeg',
//                   //     content: "mmhhh yesss",
//                   //     idFrom: 10,
//                   //     timestamp:
//                   //         DateTime.now().millisecondsSinceEpoch.toString());
//                 },
//                 child: new Image.asset(
//                   'assets/img/gif/mimi5.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () {
//                   // saveMessage(
//                   //     type: 2,
//                   //     sticker: 'assets/img/gif/mimi6.gif',
//                   //     image: 'assets/img/gabriel.jpeg',
//                   //     content: "mmhhh yesss",
//                   //     idFrom: 10,
//                   //     timestamp:
//                   //         DateTime.now().millisecondsSinceEpoch.toString());
//                 },
//                 child: new Image.asset(
//                   'assets/img/gif/mimi6.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               )
//             ],
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           ),
//           Row(
//             children: <Widget>[
//               FlatButton(
//                 onPressed: () {
//                   // saveMessage(
//                   //     type: 2,
//                   //     sticker: 'assets/img/gif/mimi7.gif',
//                   //     image: 'assets/img/gabriel.jpeg',
//                   //     content: "mmhhh yesss",
//                   //     idFrom: 10,
//                   //     timestamp:
//                   //         DateTime.now().millisecondsSinceEpoch.toString());
//                 },
//                 child: new Image.asset(
//                   'assets/img/gif/mimi7.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () {
//                   //  saveMessage(
//                   //       type: 2,
//                   //       sticker: 'assets/img/gif/mimi8.gif',
//                   //       image: 'assets/img/gabriel.jpeg',
//                   //       content: "mmhhh yesss",
//                   //       idFrom: 10,
//                   //       timestamp:
//                   //           DateTime.now().millisecondsSinceEpoch.toString());
//                 },
//                 child: new Image.asset(
//                   'assets/img/gif/mimi8.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () {
//                   // saveMessage(
//                   //       type: 2,
//                   //       sticker: 'assets/img/gif/mimi9.gif',
//                   //       image: 'assets/img/gabriel.jpeg',
//                   //       content: "mmhhh yesss",
//                   //       idFrom: 10,
//                   //       timestamp:
//                   //           DateTime.now().millisecondsSinceEpoch.toString());
//                 },
//                 child: new Image.asset(
//                   'assets/img/gif/mimi9.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               )
//             ],
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           )
//         ],
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       ),
//       decoration: new BoxDecoration(
//           border:
//               new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
//           color: Colors.white),
//       padding: EdgeInsets.all(5.0),
//       height: 180.0,
//     );
//   }

//   Widget buildLoading() {
//     return Positioned(
//       child: isLoading
//           ? Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//               color: Colors.white.withOpacity(0.8),
//             )
//           : Container(),
//     );
//   }

//   Widget buildInput() {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           // Button send image
//           Material(
//             child: new Container(
//               margin: new EdgeInsets.symmetric(horizontal: 1.0),
//               child: new IconButton(
//                 icon: new Icon(Icons.image),
//                 onPressed: () {},
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             color: Colors.white,
//           ),
//           Material(
//             child: new Container(
//               margin: new EdgeInsets.symmetric(horizontal: 1.0),
//               child: new IconButton(
//                 icon: new Icon(Icons.face),
//                 onPressed: getSticker,
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             color: Colors.white,
//           ),

//           // Edit text
//           Flexible(
//             child: Container(
//               child: TextField(
//                 style: TextStyle(
//                     color: Theme.of(context).primaryColor, fontSize: 15.0),
//                 controller: textEditingController,
//                 decoration: InputDecoration.collapsed(
//                   hintText: 'Type your message...',
//                   hintStyle: TextStyle(color: Colors.grey),
//                 ),
//                 focusNode: focusNode,
//               ),
//             ),
//           ),

//           // Button send message
//           Material(
//             child: new Container(
//               margin: new EdgeInsets.symmetric(horizontal: 8.0),
//               child: new IconButton(
//                   icon: new Icon(Icons.send),
//                   onPressed: () {
//                     if (textEditingController.text.isNotEmpty) {
//                       //  saveMessage(
//                       //       type: 0,
//                       //       sticker: 'assets/img/gif/mimi9.gif',
//                       //       image: 'assets/img/gabriel.jpeg',
//                       //       content: textEditingController.text,
//                       //       idFrom: 10,
//                       //       timestamp:
//                       //           DateTime.now().millisecondsSinceEpoch.toString());
//                       textEditingController.clear();
//                     }
//                   },
//                   color: Theme.of(context).primaryColor),
//             ),
//             color: Colors.white,
//           ),
//         ],
//       ),
//       width: double.infinity,
//       height: 50.0,
//       decoration: new BoxDecoration(
//           border:
//               new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
//           color: Colors.white),
//     );
//   }

//   Widget buildListMessage() {
//     return Flexible(
//       child: ListView.builder(
//         padding: EdgeInsets.all(10.0),
//         itemBuilder: (context, index) => buildItem(index, messagePool[index]),
//         itemCount: messagePool.length,
//         reverse: false,
//         controller: listScrollController,
//       ),
//     );
//   }
// }
