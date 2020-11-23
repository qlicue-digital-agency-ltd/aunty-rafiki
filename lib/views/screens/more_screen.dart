import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/views/components/cards/more_menu_card.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MoreMenuCard(
                    image: 'assets/access/calendar.png',
                    title: 'Baby Bump',
                    onTap: () {
                      Navigator.pushNamed(context, babyBumpPage);
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
                    image: 'assets/access/baby-stroller.png',
                    title: 'Baby Name',
                    onTap: () {
                      Navigator.pushNamed(context, babyNamePage);
                    },
                  ),
                ),
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
                  image: 'assets/access/baby-bag.png',
                  title: 'Hospital Bag',
                  onTap: () {
                    Navigator.pushNamed(context, hospitalBagPage);
                  },
                )),
                const SizedBox(width: 16.0),
                Expanded(
                  child: MoreMenuCard(
                    image: 'assets/access/faq.png',
                    title: 'FAQs',
                    onTap: () {},
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
                    image: 'assets/access/to-do-list.png',
                    title: 'To Do',
                    onTap: () {
                      Navigator.pushNamed(context, toDoListPage);
                    },
                  ),
                )
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
