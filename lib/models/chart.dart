import 'package:flutter/material.dart';

class Chart {
  final String uuid;
  final String name;
  final String lastMessage;
  final String time;
  final String chartType;
  final String avatar;

  Chart(
      {@required this.uuid,
      @required this.name,
      @required this.lastMessage,
      @required this.time,
      @required this.chartType,
      @required this.avatar});
}

List<Chart> chartList = <Chart>[
  Chart(
      avatar: 'assets/images/a.jpg',
      lastMessage: 'Hello world',
      name: 'Matias',
      time: '12:30',
      uuid: 'YYUU90989',
      chartType: 'private'),
  Chart(
      avatar: 'assets/images/b.jpg',
      lastMessage: 'Hello world',
      name: 'Goup Soccer',
      time: 'Yesterday',
      uuid: 'YYUU90989',
      chartType: 'group'),
  Chart(
      avatar: 'assets/images/c.jpeg',
      lastMessage: 'Hello iisoais world',
      name: 'Marry',
      time: 'Sunday',
      uuid: 'YYUU90989',
      chartType: 'private'),
  Chart(
      avatar: 'assets/images/d.jpeg',
      lastMessage: 'Hellohsjas world',
      name: 'Family',
      time: '12:30',
      uuid: 'YYUU90989',
      chartType: 'group'),
  Chart(
      avatar: 'assets/images/a.jpg',
      lastMessage: 'Hello world',
      name: 'Peter',
      time: '12:30',
      uuid: 'YYUU90989',
      chartType: 'private')
];
