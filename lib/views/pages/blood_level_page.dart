import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/models/blood.dart';
import 'package:aunty_rafiki/views/components/charts/chart_board.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BloodLevelTimeline extends StatefulWidget {
  @override
  _BloodLevelTimelineState createState() => _BloodLevelTimelineState();
}

class _BloodLevelTimelineState extends State<BloodLevelTimeline> {
  List<Blood> _firstHalf;
  List<Blood> _secondHalf;

  @override
  void initState() {
    _firstHalf = _generateFirstHalfData();
    _secondHalf = _generateSecondHalfData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  _BloodLevel(data: _firstHalf),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      const _MessageTimeline(
                        message: 'End of the first half!',
                      ),
                    ]),
                  ),
                  _BloodLevel(data: _secondHalf),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      const _MessageTimeline(
                        message:
                            'There will be no more action in this match as the referee signals full time.'
                            ' Arsenal goes home with the victory!',
                      ),
                    ]),
                  ),
                  const SliverPadding(padding: EdgeInsets.only(top: 20)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Blood> _generateFirstHalfData() {
    return <Blood>[
      const Blood(
        quantity: "9.0",
        level: Level.low,
        action: Status.good,
        title: 'Low',
        subtitle: 'David Luiz brings his opponent down.',
      ),
      const Blood(
        quantity: "14",
        level: Level.normal,
        action: Status.veryGood,
        title: 'Normal',
        subtitle: 'This yellow card was deserved.',
      ),
      const Blood(
        quantity: "17'",
        level: Level.low,
        action: Status.weak,
        title: 'Gooooaaaal!',
        subtitle:
            'Goal! Lionel Messi slams the ball into the open net from close range.',
      ),
      const Blood(
        quantity: "30'",
        level: Level.low,
        action: Status.weak,
        title: 'One more!',
        subtitle: 'Piqué gets a yellow card for arguing with the referee.',
      ),
      const Blood(
        quantity: "14",
        level: Level.normal,
        action: Status.excellent,
        title: 'Ouchh',
        subtitle:
            'Blood level.',
      ),
    ];
  }

  List<Blood> _generateSecondHalfData() {
    return <Blood>[
      const Blood(
        quantity: "50'",
        level: Level.low,
        action: Status.good,
        title: 'Offside!',
        subtitle:
            'The referee whistle as the Luis Suárez was trying to advance for the goal.',
      ),
      const Blood(
        quantity: "61'",
        level: Level.low,
        action: Status.excellent,
        title: 'Red card!',
        subtitle:
            'He’s off! Busquets gets his marching orders from referee Felix Brych after the VAR review.',
      ),
      const Blood(
        quantity: "72'",
        level: Level.normal,
        action: Status.good,
        title: 'Goal!',
        subtitle: 'Nicolas Pépé puts the ball past the goalkeeper!',
      ),
      const Blood(
        quantity: "84'",
        level: Level.normal,
        action: Status.weak,
        title: 'Coming from behind!!',
        subtitle:
            'Wonderful finish from Alexandre Lacazette. He drills a low shot precisely into the bottom left corner. No chance for the goalkeeper!',
      ),
    ];
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
            action: event.action,
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
    this.action,
    this.title,
    this.subtitle,
    this.isLeftChild,
  }) : super(key: key);

  final Status action;
  final String title;
  final String subtitle;
  final bool isLeftChild;

  @override
  Widget build(BuildContext context) {
    final rowChildren = <Widget>[
      _buildIconByStatus(action),
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

  Widget _buildIconByStatus(Status action) {
    return Text("🤷‍♀️",
        style: GoogleFonts.dosis(
          fontSize: 20,
          color: Colors.pink,
        ));
  }
}

class _BloodLevelIndicator extends StatelessWidget {
  const _BloodLevelIndicator({Key key, this.quantity}) : super(key: key);

  final String quantity;

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
          quantity,
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


