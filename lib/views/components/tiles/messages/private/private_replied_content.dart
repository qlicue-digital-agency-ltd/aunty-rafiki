import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/models/private_message.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrivateRepliedContent extends StatelessWidget {
  final PrivateMessage originalMessage;
  final PrivateMessage replyMessage;
  final bool byMe;

  const PrivateRepliedContent(
      {Key key,
      @required this.originalMessage,
      @required this.replyMessage,
      @required this.byMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final mediaWidth = width * 0.65;
    final noMediaWidth = width * 0.40;
    final formatter = new DateFormat('HH:mm');

    return Container(
      width: originalMessage.media.isEmpty ? noMediaWidth : mediaWidth,
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.pink,
                  height: originalMessage.media.isEmpty ? 40 : 100,
                  width: 5,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      child: RichText(
                          text: TextSpan(
                              text: byMe
                                  ? 'You\n'
                                  : '${originalMessage.idFrom}\n',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                              children: <TextSpan>[
                            TextSpan(
                                text: originalMessage.content,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13))
                          ]))),
                ),
                originalMessage.media.isEmpty
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: Loading(),
                            height: 100,
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
                              'images/img_not_available.jpeg',
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            clipBehavior: Clip.hardEdge,
                          ),
                          imageUrl: originalMessage.media[0],
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
              ],
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3,
                    ),
                    child: Text(
                      replyMessage.content,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 4, bottom: 2),
                  child: Text(
                    '${formatter.format(replyMessage.time)}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

    ///////
  }
}
