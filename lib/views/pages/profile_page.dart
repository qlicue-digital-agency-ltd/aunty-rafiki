import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
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
          title: 'Year of Birth: ${_authProvider.currentUser.yearOfBirth}'),
      Profile(icon: Icons.exit_to_app, title: 'Logout')
    ];

    List<Profile> menuList = <Profile>[
      Profile(icon: Icons.settings, title: 'Settings'),
      Profile(icon: Icons.info, title: 'About Us'),
      Profile(icon: Icons.contact_phone, title: 'Contant Us'),
      Profile(icon: Icons.lock, title: 'privacy Policy')
    ];

    List<Profile> pregnancyList = <Profile>[
      Profile(icon: Icons.face, title: 'Baby Sex'),
      Profile(icon: Icons.library_books, title: 'Baby Name'),
      Profile(icon: Icons.calendar_today, title: 'Due Date'),
      Profile(icon: Icons.calculate, title: 'Due Date Calculator')
    ];
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          elevation: 0,
          title: Text(
            Languages.of(context).labelProfileTitle,
            style: TextStyle(color: Colors.black54),
          )),
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
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  _authProvider.currentUser.photoUrl == null
                                      ? AssetImage('assets/icons/female.png')
                                      : NetworkImage(
                                          _authProvider.currentUser.photoUrl),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _authProvider.currentUser.displayName != null
                                  ? '${_authProvider.currentUser.displayName}'
                                  : "No Name",
                              style: TextStyle(
                                color: Colors.black54,
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
        _authProvider.currentUser != null
            ? SliverList(
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
              }, childCount: accountList.length))
            : SliverList(delegate: SliverChildListDelegate([])),
      ]),
    );
  }
}
