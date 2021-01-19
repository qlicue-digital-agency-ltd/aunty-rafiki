import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MediaPreviewPage extends StatelessWidget {
  final String media;

  const MediaPreviewPage({Key key, @required this.media}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: []),
        actions: [
          IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: media,
      )),
    );
  }
}
