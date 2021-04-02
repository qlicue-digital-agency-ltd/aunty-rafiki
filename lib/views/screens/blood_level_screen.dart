

import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/models/blood.dart';
import 'package:aunty_rafiki/providers/blood_level_provider.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BloodLevelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloodLevelProvider = Provider.of<BloodLevelProvider>(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Blood Level",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // Chartboard(),
          Container(
            child: _bloodLevelProvider.isFetchingBloodLevelData
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.7,
                      ),
                      Center(
                          child: Loading()),
                    ],
                  )
                : _BloodLevel(data: _bloodLevelProvider.availableBloodLevels),
          )
        ],
      ),
    );
  }
}

class _BloodLevel extends StatelessWidget {
  _BloodLevel({Key key, this.data}) : super(key: key);

  final List<Blood> data;
  //bool _isPullToRefresh = false;

  @override
  Widget build(BuildContext context) {
    final _bloodLevelProvider = Provider.of<BloodLevelProvider>(context);
    return RefreshIndicator(
      onRefresh: () {
        return _bloodLevelProvider.fetchBloodLevels();
      },
      child: data.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  InkWell(
                    onTap: () {
                      _bloodLevelProvider.fetchBloodLevels();
                    },
                    child: NoItemTile(
                      icon: 'assets/access/to-do-list.png',
                      title: 'No Blood Levels',
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final Blood event = data[index];

                final isLeftChild = event.level == Level.low;

                final child = _BloodLevelChild(
                  bloodLevel: event,
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
              itemCount: data.length,
            ),
    );
  }
}

class _BloodLevelChild extends StatelessWidget {
  _BloodLevelChild({
    Key key,
    this.bloodLevel,
    this.isLeftChild,
  }) : super(key: key);

  final Blood bloodLevel;
  final bool isLeftChild;

  // date format instance
  final DateFormat format = DateFormat("EEE, MMMM d, y");

  @override
  Widget build(BuildContext context) {
    final rowChildren = <Widget>[
      Text(bloodLevel.status.toString() == "low" ? "🤷‍♀️" : "🤰",
          style: GoogleFonts.dosis(
            fontSize: 20,
            color: Colors.pink,
          )),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          bloodLevel.title,
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
              '${format.format(bloodLevel.date)}' + "\n" + bloodLevel.subtitle,
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
