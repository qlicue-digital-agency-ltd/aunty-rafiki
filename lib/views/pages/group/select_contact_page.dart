import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/views/components/image/profile_avatar.dart';
import 'package:aunty_rafiki/views/components/tiles/contact_tile.dart';
import 'package:flutter/material.dart';


class SelectContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       // final _userProvider = Provider.of<UserProvider>(context);
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
                    return ProfileAvatar();
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
        onPressed: () {
          Navigator.pushNamed(context, createGroupPage);
        },
        child: Center(child: Icon(Icons.arrow_forward)),
      ),
    );
  }
}
