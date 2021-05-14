import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/localization/locale_constant.dart';
import 'package:aunty_rafiki/models/language_data.dart';
import 'package:aunty_rafiki/models/view/profile.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/profile_tile.dart';
import 'package:aunty_rafiki/views/pages/help_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_info_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    List<Profile> accountList = <Profile>[
      Profile(
          icon: Icons.person,
          title: Languages.of(context).labelFullName +
              ':  ${_authProvider.currentUser != null ? _authProvider.currentUser.displayName : ''}'),
      Profile(
          icon: Icons.person,
          title: Languages.of(context).labelNickname +
              ':  ${_authProvider.currentUser != null ? _authProvider.currentUser.nameInitials : ''}'),
      Profile(
          icon: Icons.calendar_today,
          title: Languages.of(context).labelYearOfBirth +
              ': ${_authProvider.currentUser != null ? _authProvider.currentUser.yearOfBirth : ''}'),
      Profile(icon: Icons.exit_to_app, title: Languages.of(context).labelLogout)
    ];

    List<Profile> menuList = <Profile>[
      Profile(icon: Icons.settings, title: Languages.of(context).labelSettings),
      Profile(icon: Icons.info, title: Languages.of(context).labelAboutUs),
      Profile(
          icon: Icons.contact_phone,
          title: Languages.of(context).labelContactUs),
      Profile(icon: Icons.lock, title: Languages.of(context).labelPrivacyPolicy)
    ];

    List<Profile> pregnancyList = <Profile>[
      Profile(icon: Icons.face, title: Languages.of(context).labelBabySex),
      Profile(
          icon: Icons.library_books,
          title: Languages.of(context).labelBabyName),
      Profile(
          icon: Icons.calendar_today,
          title: Languages.of(context).labelDueDate),
      Profile(
          icon: Icons.calculate,
          title: Languages.of(context).labelDueDateCalculator)
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          Languages.of(context).labelProfileTitle,
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          PopupMenuButton<LanguageData>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black54,
              ),
              onSelected: (LanguageData language) {
                changeLanguage(context, language.languageCode);
              },
              itemBuilder: (BuildContext context) => LanguageData.languageList()
                  .map<PopupMenuEntry<LanguageData>>(
                    (e) => PopupMenuItem<LanguageData>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: TextStyle(),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _authProvider.getUserProfile();
        },
        child: CustomScrollView(slivers: [
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
                                _authProvider.currentUser != null
                                    ? '${_authProvider.currentUser.displayName}'
                                    : "No Name",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            ]))
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(Languages.of(context).labelMenuTitle,
                    style: TextStyle(fontSize: 18)),
              ),
            ]),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
            return ProfileTile(
              profileItem: menuList[index],
              onTap: () {
                print(menuList[index].title);
                if (menuList[index].title ==
                    Languages.of(context).labelAboutUs) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AppInfoPage()));
                }
                if (menuList[index].title ==
                    Languages.of(context).labelContactUs) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HelpPage()));
                }
                if (menuList[index].title ==
                    Languages.of(context).labelPrivacyPolicy) {
                  _launchURL(
                      'https://auntierafiki.co.tz/legal/update/privacy-policy.html');
                }
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
              child: Text(Languages.of(context).labelPreganancyTitle,
                  style: TextStyle(fontSize: 18)),
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
              child: Text(Languages.of(context).labelAccountTitle,
                  style: TextStyle(fontSize: 18)),
            ),
          ])),
          _authProvider.currentUser != null
              ? SliverList(
                  delegate: SliverChildBuilderDelegate((_, index) {
                  return ProfileTile(
                    profileItem: accountList[index],
                    onTap: () {
                      print(accountList[index].title);
                      if (accountList[index].title ==
                          Languages.of(context).labelLogout) {
                        _authProvider.signOut().then((value) {
                          Navigator.pushNamed(context, landingPage);
                        });
                      }
                    },
                  );
                }, childCount: accountList.length))
              : SliverList(delegate: SliverChildListDelegate([])),
        ]),
      ),
    );
  }

  void _launchURL(String uri) async {
    String url = uri;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch';
    }
  }
}
