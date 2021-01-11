import 'package:aunty_rafiki/models/bag_item.dart';
import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalBagDetailPage extends StatelessWidget {
  final String title;
  final List<BagItem> _availableBagItmes;
  final List<BagItem> _packedBagItmes;

  const HospitalBagDetailPage({
    Key key,
    @required this.title,
    @required List<BagItem> availableBagItmes,
    @required List<BagItem> packedBagItmes,
  })  : _availableBagItmes = availableBagItmes,
        _packedBagItmes = packedBagItmes,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final _hospitalBagProvider = Provider.of<HostipalBagProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            onTap: (index) {
              // Tab index when user select it, it start from zero
            },
            tabs: [
              Tab(
                icon: Icon(Icons.card_travel),
                text: 'Suggestion',
              ),
              Tab(
                icon: Icon(Icons.card_travel),
                text: 'My Items',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: (){
                        
                      },
                      leading: IconButton(
                          tooltip: 'add',
                          icon: Icon(
                            Icons.add,
                            color: Colors.pink,
                          ),
                          onPressed: () {
                            if (title == "Mother's Bag") {
                              _hospitalBagProvider
                                  .packMotherItem(_availableBagItmes[index]);
                            } else if (title == "Baby's Bag") {
                              _hospitalBagProvider
                                  .packBabyItem(_availableBagItmes[index]);
                            } else if (title == "Birth partner's Bag") {
                              _hospitalBagProvider
                                  .packPartnerItem(_availableBagItmes[index]);
                            }
                          }),
                      title: Text(_availableBagItmes[index].name),
                    ),
                    Divider(indent: 70)
                  ],
                );
              },
              itemCount: _availableBagItmes.length,
            ),
            ListView.builder(
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: IconButton(
                          tooltip: 'delete',
                          icon: Icon(
                            Icons.delete,
                            color: Colors.pink,
                          ),
                          onPressed: () {
                            if (title == "Mother's Bag") {
                              _hospitalBagProvider
                                  .unpackMotherItem(_packedBagItmes[index]);
                            } else if (title == "Baby's Bag") {
                              _hospitalBagProvider
                                  .unpackBabyItem(_packedBagItmes[index]);
                            } else if (title == "Birth partner's Bag") {
                              _hospitalBagProvider
                                  .unpackPartnerItem(_packedBagItmes[index]);
                            }
                          }),
                      title: Text(_packedBagItmes[index].name),
                    ),
                    Divider(indent: 70)
                  ],
                );
              },
              itemCount: _packedBagItmes.length,
            ),
          ],
        ),
      ),
    );
  }
}
