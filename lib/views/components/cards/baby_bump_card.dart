import 'dart:io';

import 'package:aunty_rafiki/providers/baby_bump_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:aunty_rafiki/models/baby_bump.dart';
import 'package:provider/provider.dart';

class BabyBumpCard extends StatelessWidget {
  final BabyBump bump;

  final picker = ImagePicker();

  BabyBumpCard({@required this.bump});

  @override
  Widget build(BuildContext context) {
    final _babyBumpProvider = Provider.of<BabyBumpProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      width: screenWidth,
      child: bump.image != null && bump.image.isNotEmpty
          ? bump.bumpType == Bumps.DefaultBumps
              ? Image.asset(
                  bump.image,
                  height: screenHeight,
                  width: screenWidth,
                  fit: BoxFit.fitHeight,
                )
              : bump.bumpType == Bumps.UserBumps
                  ? Image.file(
                      File(bump.image),
                      height: screenHeight,
                      width: screenWidth,
                      fit: BoxFit.fitHeight,
                    )
                  : Container()
          : Center(
              child: InkWell(
                onTap: () async {
                  final pickedFile =
                      await picker.getImage(source: ImageSource.camera);

                  if (pickedFile != null) {
                    _babyBumpProvider.updateImageValue(
                        bump.id - 1, pickedFile.path);
                  } else {
                    print('No image selected');
                  }
                },
                child: Icon(Icons.camera),
              ),
            ),
    );
  }
}
