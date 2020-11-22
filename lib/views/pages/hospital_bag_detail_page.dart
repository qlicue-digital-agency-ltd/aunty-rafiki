import 'package:aunty_rafiki/models/bag_item.dart';
import 'package:flutter/material.dart';

class HospitalBagDetailPage extends StatelessWidget {
  final String title;
  final List<BagItem> bagItmes;

  const HospitalBagDetailPage(
      {Key key, @required this.title, @required this.bagItmes})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      leading: IconButton(
                          tooltip: 'add',
                          icon: Icon(
                            Icons.add,
                            color: Colors.pink,
                          ),
                          onPressed: () {}),
                      title: Text(bagItmes[index].name),
                    ),
                    Divider(indent: 70)
                  ],
                );
              },
              itemCount: bagItmes.length,
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
                          onPressed: () {}),
                      title: Text(bagItmes[index].name),
                    ),
                    Divider(indent: 70)
                  ],
                );
              },
              itemCount: bagItmes.length,
            ),
          ],
        ),
      ),
    );
  }
}
