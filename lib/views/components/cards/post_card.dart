import 'package:aunty_rafiki/models/post.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:share/share.dart';

import 'package:transparent_image/transparent_image.dart';

class PostCard extends StatefulWidget {
  final Post post;

  PostCard({Key key, @required this.post}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final FocusNode _bodyFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _bodyController = TextEditingController();

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
                  backgroundImage: NetworkImage(
                    widget.post.image,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(widget.post.author.name)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            widget.post.image != null
                ? InkWell(
                    onTap: () {},
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: widget.post.image,
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
            FlatButton(onPressed: () {}, child: Text('More...')),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                InkWell(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Icon(
                        Icons.chat,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {}),
                SizedBox(width: 10),
                InkWell(
                    child: Icon(
                      Icons.share,
                      color: Colors.orange,
                    ),
                    onTap: () {
                      Share.share(
                          'download our app on https://auntierafiki.co.tz',
                          subject: 'Aunty Rafiki' + widget.post.title);
                    })
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      focusNode: _bodyFocusNode,
                      controller: _bodyController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add text';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Add a comment'),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                    })
              ],
            )
          ]),
        ),
      ),
    );
  }
}
