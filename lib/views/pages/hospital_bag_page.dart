import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          Languages.of(context).labelHospitalBag,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: _hospitalBagProvider.isFetchingBagItemsData
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.7,
                  ),
                  Center(child: Loading(color: Colors.pink,)),
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
                                title: Languages.of(context).labelMotherBag)));
                  },
                  subtitle:
                      "${_hospitalBagProvider.packedMotherBagList.length}\t" +
                          Languages.of(context).labelItemsPacked,
                  title: Languages.of(context).labelMotherBag,
                ),
                HospitalBagTile(
                  icon: FontAwesomeIcons.shoppingBag,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PartnerHospitalBagDetailPage(
                                  title: Languages.of(context).labelPartnerBag,
                                )));
                  },
                  subtitle:
                      "${_hospitalBagProvider.packedPartnerBagList.length}\t" +
                          Languages.of(context).labelItemsPacked,
                  title: Languages.of(context).labelPartnerBag,
                ),
                HospitalBagTile(
                  icon: FontAwesomeIcons.shoppingBag,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BabyHospitalBagDetailPage(
                                  title: Languages.of(context).labelBabyBag,
                                )));
                  },
                  subtitle:
                      "${_hospitalBagProvider.packedBabyBagList.length}\t" +
                          Languages.of(context).labelItemsPacked,
                  title: Languages.of(context).labelBabyBag,
                ),
              ]),
      ),
    );
  }
}
