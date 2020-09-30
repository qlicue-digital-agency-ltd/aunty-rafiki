import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aunty_rafiki/providers/baby_bump_provider.dart';
import 'package:aunty_rafiki/views/components/cards/baby_bump_card.dart';

import '../../models/baby_bump.dart';

class BabyBumpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _babyBumpProvider = Provider.of<BabyBumpProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        TabBarView(
          // controller: _controller,
          children: _babyBumpProvider.bumpType == Bumps.DefaultBumps
              ? _babyBumpProvider.defaultBumps
                  .map((e) => BabyBumpCard(image: e.image))
                  .toList()
              : _babyBumpProvider.myBumps
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
                      onPressed: () {
                        _babyBumpProvider.updateBumpType(Bumps.DefaultBumps);
                      },
                      child: Text('IMAGE'),
                      padding: EdgeInsets.all(20.0),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        _babyBumpProvider.updateBumpType(Bumps.UserBumps);
                      },
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
