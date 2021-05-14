import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/models/user.dart';
import 'package:aunty_rafiki/views/pages/private_chat_room_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PrivateChartcard extends StatelessWidget {
  final User peer;
  final Function onLongPress;
  final bool isSelected;

  const PrivateChartcard(
      {Key key,
      @required this.peer,
      @required this.onLongPress,
      @required this.isSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      child: Material(
        color: isSelected ? Colors.pink[50].withOpacity(0.5) : Colors.white,
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(size.height * 0.04),
                          child: peer.photoUrl != null
                              ? CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          themeColor),
                                    ),
                                    width: 50.0,
                                    height: 50.0,
                                    padding: EdgeInsets.all(15.0),
                                  ),
                                  imageUrl: peer.photoUrl,
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.cover,
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/icons/female.png'),
                                  maxRadius: size.height * 0.04,
                                ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${peer.displayName}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(left: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontSize: 12,
                        color: peer.isAdmin == null
                            ? Colors.pink
                            : Colors.grey.shade500),
                  ),
                ],
              ),
              Divider(indent: 60)
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PrivateChatRoomPage(
                      peer: peer,
                    )));
      },
      onLongPress: onLongPress,
    );
  }
}
