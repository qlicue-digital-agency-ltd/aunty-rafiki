import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef QuickMenuCardTap = Function();

class MoreMenuCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isLocal;
  final QuickMenuCardTap onTap;

  const MoreMenuCard(
      {Key key,
      @required this.image,
      @required this.title,
      @required this.onTap,
      this.isLocal = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 2,
        child: Container(
          height: size.height / 4,
          child: Stack(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(8.0),
                  height: size.height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: isLocal
                        ? Image.asset(image, height: size.height / 16)
                        : image != null
                            ? CachedNetworkImage(
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
                                imageUrl: image,
                                fit: BoxFit.fill,
                                height: size.height / 16)
                            : Image.asset(
                                'assets/images/img_not_available.jpeg',
                                fit: BoxFit.cover,
                              ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
