

import 'package:aunty_rafiki/providers/post_provider.dart';
import 'package:aunty_rafiki/views/components/cards/post_card.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HIVMotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _postProvider = Provider.of<PostProvider>(context);

    Future<void> _getData() async {
      _postProvider.fetchPosts(userId: 1);
    }

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Mothers Living with HIV',
            style: TextStyle(color: Colors.white),
          )),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: _postProvider.isFetchingData
            ? Center(child: Loading())
            : _postProvider.availablePosts.isEmpty
                ? RefreshIndicator(
                    onRefresh: _getData,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          NoItemTile(
                            title: 'No Content',
                            icon: 'assets/access/red-ribbon.png',
                          ),
                        ],
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
                              child: PostCard(
                                post: _postProvider.availablePosts[index],
                              ),
                            );
                          }, childCount: _postProvider.availablePosts.length),
                        ),
                      ],
                    ),
                    onRefresh: _getData),
      ),
    );
  }
}
