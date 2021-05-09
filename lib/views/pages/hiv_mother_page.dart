import 'dart:async';

import 'package:animations/animations.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/post_provider.dart';
import 'package:aunty_rafiki/views/components/cards/post/loader_post_card.dart';
import 'package:aunty_rafiki/views/components/cards/post/post_card.dart';

import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:aunty_rafiki/views/pages/post_details_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HIVMotherPage extends StatefulWidget {
  @override
  _HIVMotherPageState createState() => _HIVMotherPageState();
}

class _HIVMotherPageState extends State<HIVMotherPage> {
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
    final _postProvider = Provider.of<PostProvider>(context);

    Future<void> _getData() async {
      _postProvider.fetchPosts();
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          Languages.of(context).labelHivMOthers,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: _postProvider.isFetchingData
            ? CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoaderPostCard());
                    }, childCount: 10),
                  ),
                ],
              )
            : _postProvider.availablePosts.isEmpty
                ? RefreshIndicator(
                    onRefresh: _getData,
                    child: Center(
                      child: RefreshIndicator(
                        onRefresh: _getData,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                            ),
                            _connectionStatus == 'unkwon'
                                ? NoItemTile(
                                    icon: 'assets/icons/no-wifi.png',
                                    title: Languages.of(context)
                                        .labelNoItemTileInternet,
                                    onTap: () {
                                      _postProvider.fetchPosts();
                                    },
                                  )
                                : _connectionStatus == 'ConnectivityResult.none'
                                    ? NoItemTile(
                                        icon: 'assets/icons/no-wifi.png',
                                        title: Languages.of(context)
                                            .labelNoItemTileInternet,
                                        onTap: () {
                                          _postProvider.fetchPosts();
                                        },
                                      )
                                    : NoItemTile(
                                        title: Languages.of(context)
                                            .labelNoItemTileContent,
                                        icon: 'assets/access/red-ribbon.png',
                                        onTap: () {
                                          _postProvider.fetchPosts();
                                        },
                                      ),
                          ],
                        ),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OpenContainer(
                                    transitionType:
                                        ContainerTransitionType.fadeThrough,
                                    closedBuilder: (BuildContext _,
                                        VoidCallback openContainer) {
                                      return PostCard(
                                        post:
                                            _postProvider.availablePosts[index],
                                        onTap: openContainer,
                                      );
                                    },
                                    openBuilder:
                                        (BuildContext _, VoidCallback __) {
                                      return PostDetailsPage(
                                        post:
                                            _postProvider.availablePosts[index],
                                      );
                                    }));
                          }, childCount: _postProvider.availablePosts.length),
                        ),
                      ],
                    ),
                    onRefresh: _getData),
      ),
    );
  }
}
