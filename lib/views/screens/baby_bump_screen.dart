import 'package:aunty_rafiki/models/baby_bump.dart';
import 'package:aunty_rafiki/providers/baby_bump_provider.dart';
import 'package:flutter/material.dart';
import 'package:aunty_rafiki/views/components/cards/baby_bump_card.dart';
import 'package:provider/provider.dart';

class BabyBumpScreen extends StatefulWidget {
  @override
  _BabyBumpScreenState createState() => _BabyBumpScreenState();
}

class _BabyBumpScreenState extends State<BabyBumpScreen>
    with SingleTickerProviderStateMixin {
  // TabController _controller;

  @override
  void initState() {
    // _controller = TabController(length: babyBumpModel.length, vsync: this)
    //   ..addListener(() {
    //     print(_controller.index);
    //   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _babyBumpProvider = Provider.of<BabyBumpProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        TabBarView(
          // controller: _controller,
          children: _babyBumpProvider.babyBumps
              .map((e) => BabyBumpCard(image: e.image))
              .toList(),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black.withOpacity(0.8),
            child: Consumer(
              builder: (BuildContext context, BabyBumpProvider provider,
                  Widget child) {
                return Text(provider.tabIndex.toString());
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth * 0.6,
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('IMAGE'),
                      padding: EdgeInsets.all(20.0),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('MY BUMP'),
                      padding: EdgeInsets.all(20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
