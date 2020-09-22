import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/models/chart.dart';
import 'package:aunty_rafiki/views/components/tiles/chart_tile.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chartList.length,
        itemBuilder: (_, index) {
          return ChartTile(
              chart: chartList[index],
              onTap: () => Navigator.pushNamed(context, chartRoomPage));
        });
  }
}
