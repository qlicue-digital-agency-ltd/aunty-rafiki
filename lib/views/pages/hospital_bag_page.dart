import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/hospital_bag_tile.dart';
import 'package:aunty_rafiki/views/pages/hospital_bag_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HospitalBagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _hospitalBagProvider = Provider.of<HostipalBagProvider>(context);
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
                            availableBagItmes:
                                _hospitalBagProvider.availableMotherBagList,
                            packedBagItmes:
                                _hospitalBagProvider.packedMotherBagList,
                          )
                          )
                          );
            },
            subtitle:
                "${_hospitalBagProvider.availableMotherBagList.length}  items packed",
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
                          availableBagItmes:
                              _hospitalBagProvider.availablePartnerBagList,
                          packedBagItmes:
                              _hospitalBagProvider.packedPartnerBagList)));
            },
            subtitle:
                "${_hospitalBagProvider.availablePartnerBagList.length}  items packed",
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
                            availableBagItmes:
                                _hospitalBagProvider.availableBabyBagList,
                            packedBagItmes:
                                _hospitalBagProvider.packedBabyBagList,
                          )));
            },
            subtitle:
                "${_hospitalBagProvider.availableBabyBagList.length}  items packed",
            title: "Baby's Bag",
          ),
        ]),
      ),
    );
  }
}
