import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderHospitalBagTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
              height: 100,
              width: 50,
              padding: const EdgeInsets.all(16),
            ),
          ),
          title: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
                height: 20,
                width: 70,
                color: Colors.grey[300],
              ),
          ),
          subtitle: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Container(
                height: 20,
                width: 100,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        Divider(indent: 70)
      ],
    );
  }
}
