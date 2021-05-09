import 'dart:async';

import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:badges/badges.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MotherHospitalBagDetailPage extends StatefulWidget {
  final String title;

  const MotherHospitalBagDetailPage({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _MotherHospitalBagDetailPageState createState() =>
      _MotherHospitalBagDetailPageState();
}

class _MotherHospitalBagDetailPageState
    extends State<MotherHospitalBagDetailPage> {
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
                    showBadge:
                        _hospitalBagProvider.packedMotherBagList.isNotEmpty
                            ? true
                            : false,
                    badgeColor: Colors.white,
                    badgeContent: Text(
                      '${_hospitalBagProvider.packedMotherBagList.length}',
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
            _hospitalBagProvider.availableMotherBagList.isEmpty
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
                                        .packedMotherBagList.isEmpty
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
                                    .availableMotherBagList[index],
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
                    itemCount:
                        _hospitalBagProvider.availableMotherBagList.length,
                  ),
            _hospitalBagProvider.packedMotherBagList.isEmpty
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
                                    .labelNoItemTileMotherItems),
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
                                        .packedMotherBagList[index],
                                    status: false,
                                  );
                                }),
                            title: Text(_hospitalBagProvider
                                .packedMotherBagList[index].name),
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
