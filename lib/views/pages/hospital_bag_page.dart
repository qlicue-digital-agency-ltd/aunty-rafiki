import 'dart:io';

import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/hospital_bag_tile.dart';
import 'package:aunty_rafiki/views/pages/hospital_bags/baby_hospital_bag_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'hospital_bags/mother_hospital_bag_detail_page.dart';
import 'hospital_bags/partner_hospital_bag_detail_page.dart';

class HospitalBagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _hospitalBagProvider = Provider.of<HostipalBagProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Bag'),
      ),
      body: SingleChildScrollView(
        child: _hospitalBagProvider.isFetchingBagItemsData
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.7,
                  ),
                  Center(
                      child: Platform.isAndroid
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.pink),
                            )
                          : CupertinoActivityIndicator()),
                ],
              )
            : Column(children: [
                SizedBox(height: 10),
                HospitalBagTile(
                  icon: FontAwesomeIcons.shoppingBag,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MotherHospitalBagDetailPage(
                                  title: "Mother's Bag",
                                )));
                  },
                  subtitle:
                      "${_hospitalBagProvider.packedMotherBagList.length}  items packed",
                  title: "Mother's Bag",
                ),
                HospitalBagTile(
                  icon: FontAwesomeIcons.shoppingBag,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PartnerHospitalBagDetailPage(
                                  title: "Birth partner's Bag",
                                )));
                  },
                  subtitle:
                      "${_hospitalBagProvider.packedPartnerBagList.length}  items packed",
                  title: "Birth partner's Bag",
                ),
                HospitalBagTile(
                  icon: FontAwesomeIcons.shoppingBag,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BabyHospitalBagDetailPage(
                                  title: "Baby's Bag",
                                )));
                  },
                  subtitle:
                      "${_hospitalBagProvider.packedBabyBagList.length}  items packed",
                  title: "Baby's Bag",
                ),
              ]),
      ),
    );
  }
}
