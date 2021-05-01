import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BabyHospitalBagDetailPage extends StatelessWidget {
  final String title;

  const BabyHospitalBagDetailPage({
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
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(title, style: TextStyle(color: Colors.black)),
          bottom: TabBar(
            labelColor: Colors.pink,
            indicatorColor: Colors.pink,
            unselectedLabelColor: Colors.black38,
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
                    showBadge: _hospitalBagProvider.packedBabyBagList.isNotEmpty
                        ? true
                        : false,
                    badgeColor: Colors.white,
                    badgeContent: Text(
                      '${_hospitalBagProvider.packedBabyBagList.length}',
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
            _hospitalBagProvider.availableBabyBagList.isEmpty
                ? Center(
                    child: NoItemTile(
                        icon: 'assets/icons/aunty_rafiki.png',
                        title: "Congraturations you have packed all items"),
                  )
                : ListView.builder(
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
                                        .availableBabyBagList[index],
                                    status: true,
                                  );
                                }),
                            title: Text(_hospitalBagProvider
                                .availableBabyBagList[index].name),
                          ),
                          Divider(indent: 70)
                        ],
                      );
                    },
                    itemCount: _hospitalBagProvider.availableBabyBagList.length,
                  ),
            _hospitalBagProvider.packedBabyBagList.isEmpty
                ? Center(
                    child: NoItemTile(
                        icon: 'assets/icons/aunty_rafiki.png',
                        title: "Baby Items not packed"),
                  )
                : ListView.builder(
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
                                    item: _hospitalBagProvider
                                        .packedBabyBagList[index],
                                    status: false,
                                  );
                                }),
                            title: Text(_hospitalBagProvider
                                .packedBabyBagList[index].name),
                          ),
                          Divider(indent: 70)
                        ],
                      );
                    },
                    itemCount: _hospitalBagProvider.packedBabyBagList.length,
                  ),
          ],
        ),
      ),
    );
  }
}
