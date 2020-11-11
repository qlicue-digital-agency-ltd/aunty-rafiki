import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MediaContent extends StatelessWidget {
  final Message message;
  final double width;
  List<Widget> widgetlist = List();
  MediaContent({Key key, @required this.message, @required this.width})
      : super(key: key) {
    if (message.media.length > 3) getWidgets(widgetlist);
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final formatter = new DateFormat('HH:mm');
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            message.media.length < 4
                ? Column(
                    children: message.media
                        .map((media) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.network(
                                media.toString(),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                fit: BoxFit.cover,
                              ),
                            ))
                        .toList(),
                  )
                : Column(
                    children: widgetlist.map((element) {
                    return element;
                  }).toList()),
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
                    message.text,
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
            child: Image.network(
              message.media[i],
              height: width * 0.3,
              width: width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Stack(
              children: [
                Image.network(
                  message.media[i + 1],
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
