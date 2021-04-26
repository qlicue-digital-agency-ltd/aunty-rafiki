import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/cards/more_menu_card.dart';
import 'package:aunty_rafiki/views/components/headers/home_screen_header.dart';
import 'package:aunty_rafiki/views/pages/hiv_mother_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only( right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  HomeScreenHeader(
                title: 'More',
              ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, profilePage);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => ImageCapture()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.pink, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: _authProvider.currentUser == null
                              ? AssetImage('assets/icons/female.png')
                              : _authProvider.currentUser.photoUrl == null
                                  ? AssetImage('assets/icons/female.png')
                                  : NetworkImage(
                                      _authProvider.currentUser.photoUrl),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MoreMenuCard(
                    image: 'assets/access/diet.png',
                    title: 'Food',
                    onTap: () {
                      Navigator.pushNamed(context, foodPage);
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: MoreMenuCard(
                    image: 'assets/access/appointment.png',
                    title: 'Appointments',
                    onTap: () {
                      Navigator.pushNamed(context, appointmentPage);
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: MoreMenuCard(
                  image: 'assets/access/baby-bag.png',
                  title: 'Hospital Bag',
                  onTap: () {
                    Navigator.pushNamed(context, hospitalBagPage);
                  },
                )),
                const SizedBox(width: 16.0),
                Expanded(
                  child: MoreMenuCard(
                    image: 'assets/access/timeline.png',
                    title: 'Timeline',
                    onTap: () {
                      Navigator.pushNamed(context, timeLinePage);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: MoreMenuCard(
                  image: 'assets/access/red-ribbon.png',
                  title: 'HIV Mothers',
                  onTap: () {
 
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HIVMotherPage()));
                  },
                )),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //           child: MoreMenuCard(
          //         image: 'assets/access/baby-bag.png',
          //         title: 'Hospital Bag',
          //         onTap: () {
          //           Navigator.pushNamed(context, hospitalBagPage);
          //         },
          //       )),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         child: MoreMenuCard(
          //           image: 'assets/access/faq.png',
          //           title: 'FAQs',
          //           onTap: () {},
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                // Expanded(
                //   child: MoreMenuCard(
                //     image: 'assets/access/mother.png',
                //     title: 'Baby Bump',
                //     onTap: () {
                //       Navigator.pushNamed(context, babyBumpPage);
                //     },
                //   ),
                // ),
                // const SizedBox(width: 16.0),
                // Expanded(
                //   child: MoreMenuCard(
                //     image: 'assets/access/to-do-list.png',
                //     title: 'To Do',
                //     onTap: () {
                //       Navigator.pushNamed(context, toDoListPage);
                //     },
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
