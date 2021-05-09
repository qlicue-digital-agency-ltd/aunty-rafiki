import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartnerHospitalBagDetailPage extends StatelessWidget {
  final String title;

  const PartnerHospitalBagDetailPage({
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
                text: Languages.of(context).labelSuggesitionTab,
              ),
              Tab(
                icon: Badge(
                    showBadge:
                        _hospitalBagProvider.packedPartnerBagList.isNotEmpty
                            ? true
                            : false,
                    badgeColor: Colors.white,
                    badgeContent: Text(
                      '${_hospitalBagProvider.packedPartnerBagList.length}',
                      style: TextStyle(color: Colors.pink),
                    ),
                    child: Icon(Icons.card_travel)),
                text: Languages.of(context).labelItemsTab,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _hospitalBagProvider.availablePartnerBagList.isEmpty
                ? Center(
                    child: NoItemTile(
                        icon: 'assets/icons/aunty_rafiki.png',
                        title: _hospitalBagProvider.packedPartnerBagList.isEmpty
                            ? Languages.of(context)
                                .labelNoItemTileContent: Languages.of(context).labelCongratulationsItemsPacked),
                  )
                : ListView.builder(
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              _hospitalBagProvider.packItem(
                                    item: _hospitalBagProvider
                                        .availablePartnerBagList[index],
                                    status: true,
                                  );
                            },
                            trailing: IconButton(
                                tooltip: 'add',
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.pink,
                                ),
                                onPressed: () {
                                  _hospitalBagProvider.packItem(
                                    item: _hospitalBagProvider
                                        .availablePartnerBagList[index],
                                    status: true,
                                  );
                                }),
                            title: Text(_hospitalBagProvider
                                .availablePartnerBagList[index].name),
                          ),
                          Divider(indent: 70)
                        ],
                      );
                    },
                    itemCount:
                        _hospitalBagProvider.availablePartnerBagList.length,
                  ),
            _hospitalBagProvider.packedPartnerBagList.isEmpty
                ? Center(
                    child: NoItemTile(
                        icon: 'assets/icons/aunty_rafiki.png',
                        title: "Partner's Items not packed"),
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
                                        .packedPartnerBagList[index],
                                    status: false,
                                  );
                                }),
                            title: Text(_hospitalBagProvider
                                .packedPartnerBagList[index].name),
                          ),
                          Divider(indent: 70)
                        ],
                      );
                    },
                    itemCount: _hospitalBagProvider.packedPartnerBagList.length,
                  ),
          ],
        ),
      ),
    );
  }
}
