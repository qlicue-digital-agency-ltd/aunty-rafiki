import 'dart:async';

import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:badges/badges.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BabyHospitalBagDetailPage extends StatefulWidget {
  final String title;

  const BabyHospitalBagDetailPage({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _BabyHospitalBagDetailPageState createState() =>
      _BabyHospitalBagDetailPageState();
}

class _BabyHospitalBagDetailPageState extends State<BabyHospitalBagDetailPage> {
  ///check for internet connection
  String _connectionStatus = 'unknown';

  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'unknown');
        break;
    }
  }

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
          title: Text(widget.title, style: TextStyle(color: Colors.black)),
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
                    showBadge: _hospitalBagProvider.packedBabyBagList.isNotEmpty
                        ? true
                        : false,
                    badgeColor: Colors.white,
                    badgeContent: Text(
                      '${_hospitalBagProvider.packedBabyBagList.length}',
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
            _hospitalBagProvider.availableBabyBagList.isEmpty
                ? Center(
                    child: _connectionStatus == 'unkwon'
                        ? NoItemTile(
                            icon: 'assets/icons/no-wifi.png',
                            title:
                                Languages.of(context).labelNoItemTileInternet,
                            onTap: () {
                              _hospitalBagProvider.fetchBagItems();
                            },
                          )
                        : _connectionStatus == 'ConnectivityResult.none'
                            ? NoItemTile(
                                icon: 'assets/icons/no-wifi.png',
                                title: Languages.of(context)
                                    .labelNoItemTileInternet,
                                onTap: () {
                                  _hospitalBagProvider.fetchBagItems();
                                },
                              )
                            : NoItemTile(
                                icon: 'assets/icons/aunty_rafiki.png',
                                title: _hospitalBagProvider
                                        .packedBabyBagList.isEmpty
                                    ? Languages.of(context)
                                        .labelNoItemTileContent
                                    : Languages.of(context)
                                        .labelCongratulationsItemsPacked),
                  )
                : ListView.builder(
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              _hospitalBagProvider.packItem(
                                item: _hospitalBagProvider
                                    .availableBabyBagList[index],
                                status: true,
                              );
                            },
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
                    child: _connectionStatus == 'unkwon'
                        ? NoItemTile(
                            icon: 'assets/icons/no-wifi.png',
                            title:
                                Languages.of(context).labelNoItemTileInternet,
                            onTap: () {
                              _hospitalBagProvider.fetchBagItems();
                            },
                          )
                        : _connectionStatus == 'ConnectivityResult.none'
                            ? NoItemTile(
                                icon: 'assets/icons/no-wifi.png',
                                title: Languages.of(context)
                                    .labelNoItemTileInternet,
                                onTap: () {
                                  _hospitalBagProvider.fetchBagItems();
                                },
                              )
                            : NoItemTile(
                                icon: 'assets/icons/aunty_rafiki.png',
                                title: Languages.of(context)
                                    .labelNoItemTileBabyItems),
                  )
                : ListView.builder(
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          ListTile(
                            trailing: IconButton(
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
