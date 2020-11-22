import 'package:aunty_rafiki/views/components/tiles/hospital_bag_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HospitalBagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hospital Bag')),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 10),
          HospitalBagTile(
            icon: FontAwesomeIcons.shoppingBag,
            onTap: () {},
            subtitle: "0  items packed",
            title: "Mother's Bag",
          ),
          HospitalBagTile(
            icon: FontAwesomeIcons.shoppingBag,
            onTap: () {},
            subtitle: "0  items packed",
            title: "Birth partner's Bag",
          ),
          HospitalBagTile(
            icon: FontAwesomeIcons.shoppingBag,
            onTap: () {},
            subtitle: "0  items packed",
            title: "Baby's Bag",
          ),
        ]),
      ),
    );
  }
}
