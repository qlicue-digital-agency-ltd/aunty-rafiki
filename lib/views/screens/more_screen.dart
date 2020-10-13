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
                    title: 'Daily',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: MoreMenuCard(
                    image: 'assets/access/calendar.png',
                    title: 'Weekly',
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
                    image: 'assets/access/baby-stroller.png',
                    title: 'Baby Name',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: MoreMenuCard(
                    image: 'assets/access/timeline.png',
                    title: 'Timeline',
                    onTap: () {},
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
                  onTap: () {},
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
                    image: 'assets/access/appointment.png',
                    title: 'Appointments',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: MoreMenuCard(
                    image: 'assets/access/to-do-list.png',
                    title: 'To Do',
                    onTap: () {},
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
