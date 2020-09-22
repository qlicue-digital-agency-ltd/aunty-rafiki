import 'package:aunty_rafiki/models/chart.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chartList.length,
        itemBuilder: (_, index) {
          return Container(
            height: 100,
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(chartList[index].avatar),
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
                                  chartList[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(chartList[index].lastMessage)
                              ]),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(chartList[index].time,
                                      style: TextStyle(
                                          color: chartList[index]
                                                      .messageCounter >
                                                  0
                                              ? Theme.of(context).primaryColor
                                              : Colors.black38)),
                                  chartList[index].messageCounter > 0
                                      ? Chip(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          label: Text(
                                            chartList[index]
                                                .messageCounter
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.white),
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
          );
        });
  }
}
