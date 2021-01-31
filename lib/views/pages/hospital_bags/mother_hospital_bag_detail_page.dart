
import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MotherHospitalBagDetailPage extends StatelessWidget {
  final String title;

  const MotherHospitalBagDetailPage({
    Key key,
    @required this.title,
  }) : super(key: key);
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
                icon: Badge(
                    showBadge: _hospitalBagProvider.packedMotherBagList.isNotEmpty
                        ? true
                        : false,
                    badgeColor: Colors.white,
                    badgeContent: Text(
                      '${_hospitalBagProvider.packedMotherBagList.length}',
                      style: TextStyle(color: Colors.pink),
                    ),
                    child: Icon(Icons.card_travel)),
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
                      onTap: () {},
                      leading: IconButton(
                          tooltip: 'add',
                          icon: Icon(
                            Icons.add,
                            color: Colors.pink,
                          ),
                          onPressed: () {
                            _hospitalBagProvider.packItem(
                              item: _hospitalBagProvider
                                  .availableMotherBagList[index],
                              status: true,
                            );
                          }),
                      title: Text(_hospitalBagProvider
                          .availableMotherBagList[index].name),
                    ),
                    Divider(indent: 70)
                  ],
                );
              },
              itemCount: _hospitalBagProvider.availableMotherBagList.length,
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
                            _hospitalBagProvider.packItem(
                              item:
                                  _hospitalBagProvider.packedMotherBagList[index],
                              status: false,
                            );
                          }),
                      title: Text(
                          _hospitalBagProvider.packedMotherBagList[index].name),
                    ),
                    Divider(indent: 70)
                  ],
                );
              },
              itemCount: _hospitalBagProvider.packedMotherBagList.length,
            ),
          ],
        ),
      ),
    );
  }
}
