
import 'package:aunty_rafiki/views/components/image/profile_avatar.dart';
import 'package:flutter/material.dart';

class CreateGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('New group'),
              Text('Add subject', style: TextStyle(fontSize: 14)),
              SizedBox(height: 10)
            ],
          ),
        ),
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 150),
            child: Container(
              height: 150,
              color: Colors.white,
              child: Stack(
                children: [
                  Material(
                      elevation: 2,
                      child: Container(
                        color: Colors.white70,
                        height: 125,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.camera_alt),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Type group subject here..'),
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.child_care,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {})
                            ],
                          ),
                          Text(
                              'Provide a group subject and optional group icon')
                        ]),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: FlatButton(
                        shape: CircleBorder(),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )),
                  )
                ],
              ),
            )),
      ),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
              [Center(child: Text('3 / 250 participants'))]),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            crossAxisCount: 3,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ProfileAvatar();
            },
            childCount: 20,
          ),
        )
      ]),
    );
  }
}
