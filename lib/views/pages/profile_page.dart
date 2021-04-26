import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/models/view/profile.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    List<Profile> accountList = <Profile>[
      Profile(
          icon: Icons.person,
          title: 'Firstaname:  ${_authProvider.currentUser.displayName}'),
      Profile(
          icon: Icons.person,
          title: 'Nickname:  ${_authProvider.currentUser.nameInitials}'),
      Profile(
          icon: Icons.calendar_today,
          title: 'Age: ${_authProvider.currentUser.yearOfBirth}'),
      Profile(icon: Icons.exit_to_app, title: 'Logout')
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: _authProvider.currentUser != null
                  ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, editProfilePage);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _authProvider.currentUser != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: _authProvider
                                                .currentUser.photoUrl ==
                                            null
                                        ? AssetImage('assets/icons/female.png')
                                        : NetworkImage(
                                            _authProvider.currentUser.photoUrl),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/icons/female.png'),
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _authProvider.currentUser.displayName != null
                                  ? '${_authProvider.currentUser.displayName}'
                                  : "No Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ]))
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Menu', style: TextStyle(fontSize: 18)),
            ),
          ]),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return ProfileTile(
            profileItem: menuList[index],
            onTap: () {
              print(menuList[index].title);
            },
          );
        }, childCount: menuList.length)),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Pregnancy', style: TextStyle(fontSize: 18)),
          ),
        ])),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return ProfileTile(
            profileItem: pregnancyList[index],
            onTap: () {
              print(pregnancyList[index].title);
            },
          );
        }, childCount: pregnancyList.length)),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Account', style: TextStyle(fontSize: 18)),
          ),
        ])),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return ProfileTile(
            profileItem: accountList[index],
            onTap: () {
              print(accountList[index].title);
              if (accountList[index].title == 'Logout') {
                _authProvider.signOut().then((value) {
                  Navigator.pushNamed(context, landingPage);
                  // _authProvider.setConfigurationStep = Configuration.Terms;
                });
              }
            },
          );
        }, childCount: accountList.length)),
      ]),
    );
  }
}
