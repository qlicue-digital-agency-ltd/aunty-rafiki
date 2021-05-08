

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderTrackerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              height: 32.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
