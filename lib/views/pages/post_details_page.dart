import 'package:animations/animations.dart';
import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/models/post.dart';

import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class PostDetailsPage extends StatefulWidget {
  PostDetailsPage({Key key, @required this.post}) : super(key: key);

  final Post post;

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  bool _largePhoto = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.post.title, style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share('download our app on https://auntierafiki.co.tz',
                      subject:
                          'Read from Auntie Rafiki App:' + widget.post.title);
                })
          ],
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 500),
          reverse: !_largePhoto,
          transitionBuilder: (Widget child, Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation) {
            return SharedAxisTransition(
                child: child,
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.scaled);
          },
          child: _largePhoto
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _largePhoto = !_largePhoto;
                    });
                  },
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      child: Loading(),
                      width: size.width,
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
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                    ),
                    imageUrl: widget.post.images.last.url,
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.cover,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _largePhoto = !_largePhoto;
                            });
                          },
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: Loading(),
                              width: size.width,
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
                                width: size.width,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: widget.post.images.last.url,
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title: Text('BY: ' +
                              widget.post.author.firstName +
                              '\t' +
                              widget.post.author.lastName),
                          subtitle: Text(widget.post.time.toString()),
                          leading: CircleAvatar(
                              backgroundImage: widget.post.author.avatar != null
                                  ? NetworkImage(widget.post.author.avatar)
                                  : AssetImage(
                                      'assets/images/img_not_available.jpeg')),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.post.body}',
                                style: TextStyle(fontSize: 16.0),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                      ]),
                ),
        )

        //  NoItemTile(icon: icon, title: 'No\t' + title + '\tcontent'),
        );
  }
}
