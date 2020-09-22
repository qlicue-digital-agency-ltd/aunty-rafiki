import 'package:aunty_rafiki/models/chart.dart';
import 'package:flutter/material.dart';

class ChartTile extends StatelessWidget {
  final Chart chart;
  final Function onTap;

  const ChartTile({Key key, @required this.chart, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(chart.avatar),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              chart.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(chart.lastMessage)
                          ]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(chart.time,
                                  style: TextStyle(
                                      color: chart.messageCounter > 0
                                          ? Theme.of(context).primaryColor
                                          : Colors.black38)),
                              chart.messageCounter > 0
                                  ? Chip(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text(
                                        chart.messageCounter.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ))
                                  : Container()
                            ]),
                      ),
                    )
                  ]),
                ),
                Divider()
              ],
            ),
          )
        ]),
      ),
    );
  }
}
