import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderMoreMenuCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      clipBehavior: Clip.antiAlias,
      
      child: Container(
        height: size.height / 4,
        child: Stack(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(8.0),
                height: size.height / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white10,
                ),
                child: Center(
                    child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      height: 100),
                ))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                    height: 20,
                    width: 180,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
