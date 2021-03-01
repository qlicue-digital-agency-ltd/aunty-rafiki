import 'package:flutter/material.dart';

typedef QuickMenuCardTap = Function();

class MoreMenuCard extends StatelessWidget {
  final String image;
  final String title;
  final String data;
  final bool showIcon;
  final QuickMenuCardTap onTap;

  const MoreMenuCard(
      {Key key,
      @required this.image,
      @required this.title,
      this.data,
      @required this.onTap,
      this.showIcon = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 2,
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Stack(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(8.0),
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.asset(
                      image,
                      height: MediaQuery.of(context).size.height / 16,
                    ),
                  )),
              data != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Chip(
                          backgroundColor: Theme.of(context).primaryColor,
                          label: Text(
                            data,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
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
