import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/models/tracker.dart';
import 'package:aunty_rafiki/providers/mother_provider.dart';
import 'package:aunty_rafiki/providers/tracker_provider.dart';
import 'package:aunty_rafiki/views/components/headers/home_screen_header.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:aunty_rafiki/views/components/tiles/tracker_tile.dart';
import 'package:aunty_rafiki/views/pages/tracker_blog_page.dart';
import 'package:aunty_rafiki/views/pages/tracker_page.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../components/cards/tracker_card.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  TextEditingController _dateEditingController = TextEditingController();
  String _selectedDate = '';
  @override
  Widget build(BuildContext context) {
    final _trackerProvider = Provider.of<TrackerProvider>(context);
    final _motherProvider = Provider.of<MotherProvider>(context);

    return RefreshIndicator(
      onRefresh: () {
        return _trackerProvider.fetchTrackers();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: HomeScreenHeader(
                title: Languages.of(context).labelTracker,
              ),
            ),
            _trackerProvider.isFetchingTrackerData
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.7,
                      ),
                      Center(child: Loading()),
                    ],
                  )
                : _trackerProvider.availableTrackers.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.7,
                          ),
                          _selectedDate.isEmpty
                              ? Center(
                                  child: Stack(
                                  children: [
                                    NoItemTile(
                                      icon: 'assets/access/mother.png',
                                      title:
                                          'Tap to add your first day of your last period',
                                    ),
                                    DateTimePicker(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style:
                                          TextStyle(color: Colors.transparent),
                                      type: DateTimePickerType.date,
                                      dateMask: "MMMM d, y",
                                      controller: _dateEditingController,
                                      timeLabelText: 'Date',
                                      confirmText: 'SAVE',
                                      onChanged: (val) {
                                        setState(() {
                                          _selectedDate = val;
                                        });
                                      },
                                      validator: (val) {
                                        return null;
                                      },
                                      onSaved: (val) {
                                        return print(val);
                                      },
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    ),
                                  ],
                                ))
                              : Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('My last period: ' + _selectedDate,
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              height: 50,
                                              width: 300,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _selectedDate = '';
                                                  });
                                                },
                                                child: Text(
                                                  'CANCEL',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              height: 50,
                                              width: 300,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _motherProvider
                                                      .postPregnancy(
                                                          conceptionDate:
                                                              _selectedDate)
                                                      .then((value) {
                                                    _trackerProvider
                                                        .fetchTrackers();
                                                  });
                                                },
                                                child: _motherProvider
                                                        .isSubmittingData
                                                    ? Loading()
                                                    : Text(
                                                        'SAVE MY DATE',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _trackerProvider.availableTrackers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Tracker tracker =
                              _trackerProvider.availableTrackers[index];

                          final IndicatorStyle indicator = tracker.isCheckpoint
                              ? _indicatorStyleCheckpoint(tracker)
                              : const IndicatorStyle(width: 0);

                          return TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.15,
                            isFirst: index == 0,
                            isLast: index ==
                                _trackerProvider.availableTrackers.length - 1,
                            startChild: _LeftChildTimeline(
                              tracker:
                                  _trackerProvider.availableTrackers[index],
                            ),
                            endChild: _RightChildTimeline(
                              tracker:
                                  _trackerProvider.availableTrackers[index],
                            ),
                            indicatorStyle: indicator,
                            hasIndicator: _trackerProvider
                                .availableTrackers[index].isCheckpoint,
                            beforeLineStyle: LineStyle(
                              color: tracker.color,
                              thickness: 8,
                            ),
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }

  IndicatorStyle _indicatorStyleCheckpoint(Tracker tracker) {
    return IndicatorStyle(
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
              Text(
                'Week',
                textAlign: TextAlign.center,
                style: GoogleFonts.patrickHand(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Stack(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 35,
                  ),
                  Positioned(
                    left: tracker.week > 9 ? 8 : 12,
                    top: 6,
                    child: Text(
                      tracker.week.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeftChildTimeline extends StatelessWidget {
  const _LeftChildTimeline({Key key, this.tracker}) : super(key: key);

  final Tracker tracker;

  @override
  Widget build(BuildContext context) {
    return tracker.isCheckpoint
        ? Container()
        : tracker.show
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(right: tracker.isCheckpoint ? 5 : 5),
                    child: Text(
                      tracker.day,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHand(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  )
                ],
              )
            : Container();
  }
}

class _RightChildTimeline extends StatelessWidget {
  final Tracker tracker;

  const _RightChildTimeline({Key key, @required this.tracker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _trackerProvider = Provider.of<TrackerProvider>(context);
    return tracker.isCheckpoint
        ? TrackerTile(
            tracker: tracker,
            onTap: () {
              _trackerProvider.toogleTracker = tracker.week;
            },
          )
        : tracker.show
            ? TrackerCard(
                tracker: tracker,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return tracker.content == null
                            ? TrackerPage(
                                tracker: tracker,
                              )
                            : TrackerBlogPage(
                                tracker: tracker,
                              );
                      },
                    ),
                  );
                },
              )
            : Container();
  }
}
