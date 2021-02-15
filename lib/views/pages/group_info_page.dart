import 'package:aunty_rafiki/models/chat.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class GroupInfoPage extends StatelessWidget {
  final Chat chat;

  const GroupInfoPage({Key key, @required this.chat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverAppBar(
            expandedHeight: 300,
            stretch: true,
            stretchTriggerOffset: 150.0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.pink,
                ),
                onPressed: () {},
              )
            ],
            onStretchTrigger: () {
              return;
            },
            flexibleSpace: FlexibleSpaceBar(
              title: Text(chat.name),
              centerTitle: false,
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              background: chat.avatar.isNotEmpty
                  ? FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: chat.avatar,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/icons/female.png',
                      fit: BoxFit.cover,
                    ),
            )),
        SliverList(
          delegate: SliverChildListDelegate([
            InkWell(
              onTap: () {
                print('LOVE');
              },
              child: Material(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 20, bottom: 20),
                    child: Row(children: [
                      Expanded(child: Text('Add group description'))
                    ]),
                  )),
            ),
            SizedBox(height: 20),
            Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('Mute Notifications')),
                        Switch(
                            value: true,
                            onChanged: (value) {
                              print(value);
                            })
                      ],
                    ),
                    Divider(indent: 10),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Expanded(child: Text('Media Visibility')),
                        ],
                      ),
                    ),
                    Divider(indent: 20),
                  ],
                ),
              ),
            )
          ]),
        ),
      ]),
    );
  }
}
