import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OtherMediaContent extends StatefulWidget {
  final Message message;
  final double width;

  const OtherMediaContent({Key key, this.message, this.width})
      : super(key: key);

  @override
  _OtherMediaContentState createState() => _OtherMediaContentState();
}

class _OtherMediaContentState extends State<OtherMediaContent> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
        child: _controller.value.initialized
            ? VideoPlayer(_controller)
            : Container());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
