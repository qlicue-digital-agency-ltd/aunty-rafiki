import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/models/post.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/pages/post_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:share/share.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final Function onTap;

  PostCard({Key key, @required this.post, @required this.onTap})
      : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: widget.post.author.avatar != null
                      ? NetworkImage(
                          widget.post.author.avatar,
                        )
                      : AssetImage('assets/images/img_not_available.jpeg'),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(widget.post.author.firstName +
                    '\t' +
                    widget.post.author.lastName)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            widget.post.images.isNotEmpty
                ? InkWell(
                    onTap: widget.onTap,
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Container(
                        child: Loading(),
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
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      ),
                      imageUrl: widget.post.images.last.url,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                // InkWell(
                //     child: Transform(
                //       alignment: Alignment.center,
                //       transform: Matrix4.rotationY(math.pi),
                //       child: Icon(
                //         Icons.chat,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     onTap: () {}),
                // SizedBox(width: 10),
                InkWell(
                    child: Icon(
                      Icons.share,
                      color: Colors.orange,
                    ),
                    onTap: () {
                      Share.share(
                          'download our app on https://auntierafiki.co.tz',
                          subject: 'Read from Auntie Rafiki App:' +
                              widget.post.title);
                    })
              ],
            ),
            SizedBox(height: 10),
            // Divider(),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: Form(
            //         key: _formKey,
            //         child: TextFormField(
            //           focusNode: _bodyFocusNode,
            //           controller: _bodyController,
            //           validator: (value) {
            //             if (value.isEmpty) {
            //               return 'Please add text';
            //             } else
            //               return null;
            //           },
            //           decoration: InputDecoration(
            //               border: InputBorder.none, hintText: 'Add a comment'),
            //         ),
            //       ),
            //     ),
            //     IconButton(
            //         icon: Icon(
            //           Icons.send,
            //           color: Colors.orange,
            //         ),
            //         onPressed: () {
            //           if (_formKey.currentState.validate()) {}
            //         })
            //   ],
            // )
          ]),
        ),
      ),
    );
  }
}
