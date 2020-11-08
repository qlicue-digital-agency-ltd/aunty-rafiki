import 'package:aunty_rafiki/models/media.dart';
import 'package:flutter/material.dart';



import 'media_preview_page.dart';

class MediaPreviewListPage extends StatelessWidget {
  final List<Media> media;

  const MediaPreviewListPage({Key key, @required this.media})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       
       
        ]),
        actions: [
          IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: ListView.builder(
              itemCount: media.length,
              itemBuilder: (_, index) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MediaPreviewPage(
                                  media: media[index],
                                ))),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Hero(
                        tag: media[index].url,
                        child: Image.asset(media[index].url),
                      ),
                    ),
                  ))),
    );
  }
}
