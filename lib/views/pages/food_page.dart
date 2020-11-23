import 'package:aunty_rafiki/views/components/cards/more_menu_card.dart';
import 'package:flutter/material.dart';

class FoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food')),
      body: Column(children: [
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
                  title: 'Diet',
                  onTap: () {
                    //  Navigator.pushNamed(context, bloodLevelPage);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: MoreMenuCard(
                  image: 'assets/access/appointment.png',
                  title: 'Greens',
                  onTap: () {
                    //   Navigator.pushNamed(context, appointmentPage);
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
                  title: 'Juice',
                  onTap: () {
                    //   Navigator.pushNamed(context, babyNamePage);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: MoreMenuCard(
                  image: 'assets/access/timeline.png',
                  title: 'Fruits',
                  onTap: () {
                    // Navigator.pushNamed(context, timeLinePage);
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
                  image: 'assets/access/baby-stroller.png',
                  title: 'Expecting',
                  onTap: () {
                    //   Navigator.pushNamed(context, babyNamePage);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: MoreMenuCard(
                  image: 'assets/access/timeline.png',
                  title: 'Weaning',
                  onTap: () {
                    // Navigator.pushNamed(context, timeLinePage);
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
