import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/material.dart';

class BabyNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baby Names')),
      body: NoItemTile(icon: 'assets/access/baby-stroller.png', title: 'No\t' +"baby names" + '\tcontent'),
    );
  }
}
