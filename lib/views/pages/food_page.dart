import 'dart:async';

import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/food_provider.dart';
import 'package:aunty_rafiki/views/components/cards/menu/load_more_menu_card.dart';
import 'package:aunty_rafiki/views/components/cards/menu/more_menu_card.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';

import 'package:aunty_rafiki/views/pages/recipe_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
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
    final _foodProvider = Provider.of<FoodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          Languages.of(context).labelFood,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _foodProvider.isFetchingFoodData
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
              ),
              itemCount: 10,
              padding: EdgeInsets.all(8),
              itemBuilder: (BuildContext ctx, index) {
                return LoaderMoreMenuCard();
              })
          : _foodProvider.availableFoods.isEmpty
              ? Center(
                  child: _connectionStatus == 'unkwon'
                      ? NoItemTile(
                          icon: 'assets/icons/no-wifi.png',
                          title: Languages.of(context).labelNoItemTileInternet,
                          onTap: () {
                            _foodProvider.fetchFoods();
                          },
                        )
                      : _connectionStatus == 'ConnectivityResult.none'
                          ? NoItemTile(
                              icon: 'assets/icons/no-wifi.png',
                              title:
                                  Languages.of(context).labelNoItemTileInternet,
                              onTap: () {
                                _foodProvider.fetchFoods();
                              },
                            )
                          : NoItemTile(
                              icon: 'assets/access/diet.png',
                              title:
                                  Languages.of(context).labelNoItemTileContent,
                              onTap: () {
                                _foodProvider.fetchFoods();
                              },
                            ))
              : RefreshIndicator(
                  onRefresh: () {
                    return _foodProvider.fetchFoods();
                  },
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemCount: _foodProvider.availableFoods.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (BuildContext ctx, index) {
                        return MoreMenuCard(
                          isLocal: false,
                          title: _foodProvider.availableFoods[index].title,
                          image: _foodProvider
                                  .availableFoods[index].images.isNotEmpty
                              ? _foodProvider
                                  .availableFoods[index].images.last.url
                              : null,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RecipePage(
                                          food: _foodProvider
                                              .availableFoods[index],
                                          title: _foodProvider
                                              .availableFoods[index].title,
                                        )));
                          },
                        );
                      }),
                ),
    );
  }
}
