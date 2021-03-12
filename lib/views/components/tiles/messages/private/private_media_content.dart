import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/models/private_message.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/pages/media_preview_list_page.dart';
import 'package:aunty_rafiki/views/pages/media_preview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class PrivateMediaContent extends StatelessWidget {
  final PrivateMessage message;
  final double width;
  final bool byMe;
  List<Widget> widgetlist = List();
  PrivateMediaContent(
      {Key key,
      @required this.message,
      @required this.width,
      @required this.byMe})
      : super(key: key) {
    if (message.media.length > 3) getWidgets(widgetlist);
  }
  @override
  Widget build(BuildContext context) {
    final formatter = new DateFormat('HH:mm');
    double _imageHolderHeight = MediaQuery.of(context).size.height * 0.2;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            byMe
                ? Container()
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 6.0, top: 8.0, right: 6.0),
                    child: RichText(
                        text: TextSpan(
                      text: '${message.idFrom}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    )),
                  ),
            message.media.length < 4
                ? InkWell(
                    onTap: () {
                      if (message.media.length == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MediaPreviewPage(
                                      media: message.media[0],
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MediaPreviewListPage(
                                      media: message.media,
                                    )));
                      }
                    },
                    child: Container(
                      width: width * 0.58,
                      child: Column(
                        children: message.media
                            .map((media) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                MediaPreviewListPage(
                                                  media: message.media,
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: _imageHolderHeight,
                                          child: Center(
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  Container(
                                                child: Loading(),
                                                height: _imageHolderHeight,
                                                padding: EdgeInsets.all(70.0),
                                                decoration: BoxDecoration(
                                                  color: greyColor2,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8.0),
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Material(
                                                child: Image.asset(
                                                  'assets/images/img_not_available.jpeg',
                                                  height: _imageHolderHeight,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0),
                                                ),
                                                clipBehavior: Clip.hardEdge,
                                              ),
                                              imageUrl: media.toString(),
                                              height: _imageHolderHeight,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  )
                : Container(
                    width: width * 0.62,
                    child: Column(
                        children: widgetlist.map((element) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MediaPreviewListPage(
                                          media: message.media,
                                        )));
                          },
                          child: element);
                    }).toList()),
                  ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxWidth: width - 80),
                  padding: EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(right: 4, bottom: 2),
            child: Text(
              '${formatter.format(message.time)}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void getWidgets(List<Widget> wlist) {
    for (int i = 0; i < 2; i++) {
      wlist.add(Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CachedNetworkImage(
              placeholder: (context, url) => Container(
                child: Loading(),
                height: width * 0.3,
                width: width * 0.3,
                padding: EdgeInsets.all(70.0),
                decoration: BoxDecoration(
                  color: greyColor2,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Material(
                child: Image.asset(
                  'assets/images/img_not_available.jpeg',
                  height: width * 0.3,
                  width: width * 0.3,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                clipBehavior: Clip.hardEdge,
              ),
              imageUrl: message.media[i],
              height: width * 0.3,
              width: width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Stack(
              children: [
                CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: Loading(),
                    height: width * 0.3,
                    width: width * 0.3,
                    padding: EdgeInsets.all(70.0),
                    decoration: BoxDecoration(
                      color: greyColor2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Material(
                    child: Image.asset(
                      'assets/images/img_not_available.jpeg',
                      height: width * 0.3,
                      width: width * 0.3,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                  ),
                  imageUrl: message.media[i + 1],
                  height: width * 0.3,
                  width: width * 0.3,
                  fit: BoxFit.cover,
                ),
                i == 1
                    ? message.media.length - 4 > 0
                        ? Container(
                            height: width * 0.3,
                            width: width * 0.3,
                            color: Colors.black38,
                            child: Center(
                              child: Text(
                                '+' + (message.media.length - 4).toString(),
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : Container()
                    : Container()
              ],
            ),
          )
        ],
      ));
    }
  }
}
