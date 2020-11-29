import 'package:aunty_rafiki/models/bag_item.dart';
import 'package:aunty_rafiki/views/components/tiles/hospital_bag_tile.dart';
import 'package:aunty_rafiki/views/pages/hospital_bag_detail_page.dart';
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HospitalBagDetailPage(
                            title: "Mother's Bag",
                            bagItmes: motherBag,
                          )));
            },
            subtitle: "0  items packed",
            title: "Mother's Bag",
          ),
          HospitalBagTile(
            icon: FontAwesomeIcons.shoppingBag,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HospitalBagDetailPage(
                            title: "Birth partner's Bag",
                            bagItmes: partnerBag,
                          )));
            },
            subtitle: "0  items packed",
            title: "Birth partner's Bag",
          ),
          HospitalBagTile(
            icon: FontAwesomeIcons.shoppingBag,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HospitalBagDetailPage(
                            title: "Baby's Bag",
                            bagItmes: babyBag,
                          )));
            },
            subtitle: "0  items packed",
            title: "Baby's Bag",
          ),
        ]),
      ),
    );
  }
}
