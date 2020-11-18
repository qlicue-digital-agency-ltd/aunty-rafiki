import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/models/blood.dart';
import 'package:aunty_rafiki/providers/blood_level_provider.dart';
import 'package:aunty_rafiki/views/components/charts/chart_board.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BloodLevelTimeline extends StatefulWidget {
  @override
  _BloodLevelTimelineState createState() => _BloodLevelTimelineState();
}

class _BloodLevelTimelineState extends State<BloodLevelTimeline> {
  @override
  Widget build(BuildContext context) {
    final _bloodLevelProvider = Provider.of<BloodLevelProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Level',
          style: GoogleFonts.dosis(
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              'Blood Level Chart',
              style: GoogleFonts.dosis(
                fontSize: 20,
                color: Colors.pink.withOpacity(0.7),
              ),
            ),
            Chartboard(),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  _BloodLevel(data: _bloodLevelProvider.availableBloodLevels),
                  const SliverPadding(padding: EdgeInsets.only(top: 20)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BloodLevel extends StatelessWidget {
  const _BloodLevel({Key key, this.data}) : super(key: key);

  final List<Blood> data;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final Blood event = data[index];

          final isLeftChild = event.level == Level.low;

          final child = _BloodLevelChild(
            status: event.status,
            title: event.title,
            subtitle: event.subtitle,
            isLeftChild: isLeftChild,
          );

          return TimelineTile(
            alignment: TimelineAlign.center,
            endChild: isLeftChild ? null : child,
            startChild: isLeftChild ? child : null,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              indicator: _BloodLevelIndicator(quantity: event.quantity),
              drawGap: true,
            ),
            beforeLineStyle: LineStyle(
              color: Colors.pink.withOpacity(0.2),
              thickness: 3,
            ),
          );
        },
        childCount: data.length,
      ),
    );
  }
}

class _MessageTimeline extends StatelessWidget {
  const _MessageTimeline({Key key, this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.dosis(
                  fontSize: 16,
                  color: Colors.pink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BloodLevelChild extends StatelessWidget {
  const _BloodLevelChild({
    Key key,
    this.status,
    this.title,
    this.subtitle,
    this.isLeftChild,
  }) : super(key: key);

  final Status status;
  final String title;
  final String subtitle;
  final bool isLeftChild;

  @override
  Widget build(BuildContext context) {
    final rowChildren = <Widget>[
      _buildIconByStatus(status),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          title,
          textAlign: isLeftChild ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.dosis(
            fontSize: 18,
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];

    return Padding(
      padding: isLeftChild
          ? const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10)
          : const EdgeInsets.only(right: 16, top: 10, bottom: 10, left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: isLeftChild ? rowChildren.reversed.toList() : rowChildren,
          ),
          Flexible(
            child: Text(
              subtitle,
              textAlign: isLeftChild ? TextAlign.right : TextAlign.left,
              style: GoogleFonts.dosis(
                fontSize: 16,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconByStatus(Status status) {
    return Text("🤷‍♀️",
        style: GoogleFonts.dosis(
          fontSize: 20,
          color: Colors.pink,
        ));
  }
}

class _BloodLevelIndicator extends StatelessWidget {
  const _BloodLevelIndicator({Key key, this.quantity}) : super(key: key);

  final double quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.pink.withOpacity(0.2),
          width: 3,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$quantity',
          style: GoogleFonts.dosis(
            fontSize: 18,
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
