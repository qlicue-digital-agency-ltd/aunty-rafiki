import 'dart:async';

import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/models/blood.dart';
import 'package:aunty_rafiki/providers/blood_level_provider.dart';
import 'package:aunty_rafiki/views/components/headers/home_screen_header.dart';
import 'package:aunty_rafiki/views/components/headers/loading_home_screen_header.dart';

import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BloodLevelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloodLevelProvider = Provider.of<BloodLevelProvider>(context);
    return RefreshIndicator(
      onRefresh: () {
        return _bloodLevelProvider.fetchBloodLevels();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: _bloodLevelProvider.isFetchingBloodLevelData
                  ? LoadingHomeScreenHeader()
                  : HomeScreenHeader(
                      title: Languages.of(context).labelBloodLevel,
                    ),
            ),
            Container(
              child: _bloodLevelProvider.isFetchingBloodLevelData
                  ? _LoadingBloodLevel()
                  : _BloodLevel(data: _bloodLevelProvider.availableBloodLevels),
            )
          ],
        ),
      ),
    );
  }
}

class _BloodLevel extends StatefulWidget {
  _BloodLevel({Key key, this.data}) : super(key: key);

  final List<Blood> data;

  @override
  __BloodLevelState createState() => __BloodLevelState();
}

class __BloodLevelState extends State<_BloodLevel> {
  ///check for internet connection
  String _connectionStatus = 'unknown';

  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'unknown');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _bloodLevelProvider = Provider.of<BloodLevelProvider>(context);
    return RefreshIndicator(
      onRefresh: () {
        return _bloodLevelProvider.fetchBloodLevels();
      },
      child: widget.data.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  _connectionStatus == 'unkwon'
                      ? NoItemTile(
                          icon: 'assets/icons/no-wifi.png',
                          title: Languages.of(context).labelNoItemTileInternet,
                          onTap: () {
                            _bloodLevelProvider.fetchBloodLevels();
                          },
                        )
                      : _connectionStatus == 'ConnectivityResult.none'
                          ? NoItemTile(
                              icon: 'assets/icons/no-wifi.png',
                              title:
                                  Languages.of(context).labelNoItemTileInternet,
                              onTap: () {
                                _bloodLevelProvider.fetchBloodLevels();
                              },
                            )
                          : NoItemTile(
                              onTap: () {
                                _bloodLevelProvider.fetchBloodLevels();
                              },
                              icon: 'assets/access/to-do-list.png',
                              title: Languages.of(context)
                                  .labelNoItemTileBloodLevel,
                            ),
                ],
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final Blood event = widget.data[index];

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
              itemCount: widget.data.length,
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

//loader........

class _LoadingBloodLevel extends StatelessWidget {
  //bool _isPullToRefresh = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final isLeftChild = index % 2 == 0;

        final child = _LoaderBloodLevelChild(
          isLeftChild: isLeftChild,
        );

        return TimelineTile(
          alignment: TimelineAlign.center,
          endChild: isLeftChild ? null : child,
          startChild: isLeftChild ? child : null,
          indicatorStyle: IndicatorStyle(
            width: 40,
            height: 40,
            indicator: _LoaderBloodLevelIndicator(),
            drawGap: true,
          ),
          beforeLineStyle: LineStyle(
            color: Colors.grey[300],
            thickness: 3,
          ),
        );
      },
      itemCount: 10,
    );
  }
}

class _LoaderBloodLevelChild extends StatelessWidget {
  _LoaderBloodLevelChild({
    Key key,
    this.isLeftChild,
  }) : super(key: key);

  final bool isLeftChild;

  @override
  Widget build(BuildContext context) {
    final rowChildren = <Widget>[
      Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          height: 20,
          width: 70,
          color: Colors.grey[300],
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
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
          SizedBox(
            height: 5,
          ),
          Flexible(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                height: 100,
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoaderBloodLevelIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300],
            width: 3,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
