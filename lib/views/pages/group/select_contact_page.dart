import 'package:aunty_rafiki/views/components/tiles/contact_tile.dart';
import 'package:flutter/material.dart';

class SelectContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('New group'),
            Text('Add participants', style: TextStyle(fontSize: 14)),
            SizedBox(height: 10)
          ],
        ),
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: Container(
              height: 120,
              color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: [
                              CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('assets/images/b.jpg')),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    print('object');
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.pink,
                                      ),
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                          Text('Robin')
                        ],
                      ),
                    );
                  }),
            )),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) {
            return ContactTile(
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Center(child: Icon(Icons.arrow_forward)),
      ),
    );
  }
}
