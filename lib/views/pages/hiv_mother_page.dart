import 'package:animations/animations.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/post_provider.dart';
import 'package:aunty_rafiki/views/components/cards/post_card.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:aunty_rafiki/views/pages/post_details_page.dart';
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
            ? Center(
                child: Loading(
                color: Colors.pink,
              ))
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
                            NoItemTile(
                              title:
                                  Languages.of(context).labelNoItemTileContent,
                              icon: 'assets/access/red-ribbon.png',
                              onTap: () {
                                _postProvider.fetchPosts(userId: 1);
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
