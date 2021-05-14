import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingHomeScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child:
              Container(height: 32.0, width: MediaQuery.of(context).size.width *0.3, color: Colors.grey[300])
              ),
    );
  }
}
