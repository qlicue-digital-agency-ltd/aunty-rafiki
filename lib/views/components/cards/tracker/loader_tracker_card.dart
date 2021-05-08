import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderTrackerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: 70.0,
                height: 20,
                color: Colors.grey[300],
              ),
            ),
            subtitle: Container(
              width: 200.0,
              height: 20,
              color: Colors.grey[300],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
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
                      child: Container(
                        height: 20,
                        width: 100,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 14.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 20,
                              width: double.infinity,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
