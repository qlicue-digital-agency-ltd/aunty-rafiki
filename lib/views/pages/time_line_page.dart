import 'package:aunty_rafiki/models/time_line.dart';
import 'package:aunty_rafiki/providers/timeline_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:aunty_rafiki/views/pages/time_line_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
        title: Text('Time Line'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Expanded(
              child: _timelineProvider.isFetchingTimelineData
                  ? Center(child: CircularProgressIndicator())
                  : _Timeline(data: _timelineProvider.availableTimelines),
            )
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  _Timeline({Key key, this.data}) : super(key: key);

  final List<Timeline> data;
  //bool _isPullToRefresh = false;

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

          return data.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      NoItemTile(
                        icon: 'assets/access/timeline.png',
                        title: 'No Timeline Levels',
                      ),
                    ],
                  ),
                )
              : TimelineTile(
                  alignment: TimelineAlign.center,
                  endChild: isLeftChild
                      ? null
                      : _TimelineChild(
                          timeline: data[index],
                          isLeftChild: isLeftChild,
                        ),
                  startChild: isLeftChild
                      ? _TimelineChild(
                          timeline: data[index],
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
                                    "${data[index].time}",
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
        itemCount: data.isEmpty ? 1 : data.length,
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
                Image.network(
                  timeline.image,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                Row(
                  children: [Expanded(child: Text(timeline.body))],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
