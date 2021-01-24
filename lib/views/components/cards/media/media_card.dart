// import 'package:aunty_rafiki/models/media.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class MediaCard extends StatefulWidget {
//   final Media media;

//   MediaCard({Key key, @required this.media}) : super(key: key);

//   @override
//   _MediaCardState createState() => _MediaCardState();
// }

// class _MediaCardState extends State<MediaCard> {
//   VideoPlayerController _controller;
//   @override
//   void initState() {
//     super.initState();
//     if (widget.media.type == 'video')
//       _controller = VideoPlayerController.network(widget.media.url)
//         ..initialize().then((_) {
//           setState(() {});
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: widget.media.url,
//       child: widget.media.type == 'image'
//           ? Image.asset(
//               widget.media.url,
//               fit: BoxFit.cover,
//               width: MediaQuery.of(context).size.width * 0.7,
//             )
//           : Container(
//               width: MediaQuery.of(context).size.width * 0.7,
//               child: _controller.value.initialized
//                   ? AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     )
//                   : Container(),
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
