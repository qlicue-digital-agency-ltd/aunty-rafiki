import 'dart:async';

import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/models/time_line.dart';
import 'package:aunty_rafiki/providers/timeline_provider.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:aunty_rafiki/views/pages/time_line_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    final _timelineProvider = Provider.of<TimelineProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          Languages.of(context).labelTimeline,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Expanded(
              child: _timelineProvider.isFetchingTimelineData
                  ? _LoadingTimeline()
                  : _Timeline(data: _timelineProvider.availableTimelines),
            )
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatefulWidget {
  _Timeline({Key key, this.data}) : super(key: key);

  final List<Timeline> data;

  @override
  __TimelineState createState() => __TimelineState();
}

class __TimelineState extends State<_Timeline> {
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
    final _timelineProvider = Provider.of<TimelineProvider>(context);
    return RefreshIndicator(
      onRefresh: () {
        return _timelineProvider.fetchTimelines();
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final isLeftChild = index.isEven;

          return widget.data.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      _connectionStatus == 'unkwon'
                          ? NoItemTile(
                              icon: 'assets/icons/no-wifi.png',
                              title:
                                  Languages.of(context).labelNoItemTileInternet,
                              onTap: () {
                                _timelineProvider.fetchTimelines();
                              },
                            )
                          : _connectionStatus == 'ConnectivityResult.none'
                              ? NoItemTile(
                                  icon: 'assets/icons/no-wifi.png',
                                  title: Languages.of(context)
                                      .labelNoItemTileInternet,
                                  onTap: () {
                                    _timelineProvider.fetchTimelines();
                                  },
                                )
                              : NoItemTile(
                                  icon: 'assets/access/timeline.png',
                                  title: Languages.of(context)
                                      .labelNoItemTileContent,
                                  onTap: () {
                                    _timelineProvider.fetchTimelines();
                                  },
                                ),
                    ],
                  ),
                )
              : TimelineTile(
                  alignment: TimelineAlign.center,
                  endChild: isLeftChild
                      ? null
                      : _TimelineChild(
                          timeline: widget.data[index],
                          isLeftChild: isLeftChild,
                        ),
                  startChild: isLeftChild
                      ? _TimelineChild(
                          timeline: widget.data[index],
                          isLeftChild: isLeftChild,
                        )
                      : null,
                  indicatorStyle: IndicatorStyle(
                    width: 46,
                    height: 100,
                    indicator: Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                Positioned(
                                  left: 12,
                                  top: 6,
                                  child: Text(
                                    "${widget.data[index].time}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.patrickHand(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Month',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.patrickHand(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.pink.withOpacity(0.2),
                    thickness: 3,
                  ),
                );
        },
        itemCount: widget.data.isEmpty ? 1 : widget.data.length,
      ),
    );
  }
}

class _TimelineChild extends StatelessWidget {
  _TimelineChild({
    Key key,
    this.timeline,
    this.isLeftChild,
  }) : super(key: key);

  final Timeline timeline;
  final bool isLeftChild;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftChild
          ? const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10)
          : const EdgeInsets.only(right: 16, top: 10, bottom: 10, left: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => TimelineDetailPage(
                        timeline: timeline,
                      )));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              children: [
                timeline.images.isEmpty
                    ? Container()
                    : CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: Loading(
                            color: Colors.pink,
                          ),
                          padding: EdgeInsets.all(70.0),
                          decoration: BoxDecoration(
                            color: greyColor2,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Material(
                          child: Image.asset(
                            'assets/images/img_not_available.jpeg',
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          clipBehavior: Clip.hardEdge,
                        ),
                        imageUrl: timeline.images.last.url,
                        width: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.fill,
                      ),
                Row(
                  children: [
                    Expanded(
                        child: Text(timeline.body,
                            maxLines: 10, overflow: TextOverflow.ellipsis))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///loading

class _LoadingTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final isLeftChild = index.isEven;

        return TimelineTile(
          alignment: TimelineAlign.center,
          endChild: isLeftChild
              ? null
              : _LoaderTimelineChild(
                  isLeftChild: isLeftChild,
                ),
          startChild: isLeftChild
              ? _LoaderTimelineChild(
                  isLeftChild: isLeftChild,
                )
              : null,
          indicatorStyle: IndicatorStyle(
            width: 46,
            height: 100,
            indicator: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Container(
                            height: 35,
                            width: 35,
                            color: Colors.grey[300],
                          ),
                        ),
                        Positioned(
                          left: 12,
                          top: 6,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: Container(
                              height: 10,
                              width: 10,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        height: 10,
                        width: 30,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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

class _LoaderTimelineChild extends StatelessWidget {
  _LoaderTimelineChild({
    Key key,
    this.isLeftChild,
  }) : super(key: key);

  final bool isLeftChild;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftChild
          ? const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10)
          : const EdgeInsets.only(right: 16, top: 10, bottom: 10, left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: [
              Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                      color: Colors.grey[300],
                      height: 100,
                      width: MediaQuery.of(context).size.width / 2)),
              Row(
                children: [
                  Expanded(
                      child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      color: Colors.grey[300],
                      height: 20,
                    ),
                  ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
