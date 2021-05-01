import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/material.dart';

class BabyNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Baby Names', style: TextStyle(color: Colors.black)),
           ),
      body: NoItemTile(
          icon: 'assets/access/baby-stroller.png',
          title: 'No\t' + "baby names" + '\tcontent'),
    );
  }
}
