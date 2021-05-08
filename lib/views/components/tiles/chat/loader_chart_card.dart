import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderChartcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
                      borderRadius: BorderRadius.circular(size.height * 0.04),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          maxRadius: size.height * 0.04,
                        ),
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
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                height: 20,
                                width: 180.0,
                                color: Colors.grey[300],
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  height: 20,
                  width: 40,
                  color: Colors.grey[300],
                ),
              )
            ],
          ),
          Divider(indent: 60)
        ],
      ),
    );
  }
}
