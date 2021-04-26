import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';

class VideoMediaContent extends StatefulWidget {
  final Message message;
  final double width;

  const VideoMediaContent({Key key, this.message, this.width})
      : super(key: key);

  @override
  _VideoMediaContentState createState() => _VideoMediaContentState();
}

class _VideoMediaContentState extends State<VideoMediaContent> {
  ///VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //     'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      // child: _controller.value.isInitialized
      //     ? Stack(
      //         children: [
      //           VideoPlayer(_controller),
      //           Align(
      //             alignment: Alignment.center,
      //             child: IconButton(
      //               onPressed: () {
      //                 setState(() {
      //                   _controller.value.isPlaying
      //                       ? _controller.pause()
      //                       : _controller.play();
      //                 });
      //               },
      //               icon: Icon(
      //                 _controller.value.isPlaying
      //                     ? Icons.pause
      //                     : Icons.play_arrow,
      //               ),
      //             ),
      //           )
      //         ],
      //       )
      //     : Container()
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }
}
