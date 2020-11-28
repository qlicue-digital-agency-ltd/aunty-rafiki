import 'package:aunty_rafiki/views/components/cards/more_menu_card.dart';
import 'package:aunty_rafiki/views/pages/food_details_page.dart';
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
                  image: 'assets/food/diet.png',
                  title: 'Diet',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FoodDetailsPage(
                                  title: 'Diet',
                                  icon: 'assets/food/diet.png',
                                  cover: 'assets/chats/1.jpg',
                                )));
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: MoreMenuCard(
                  image: 'assets/food/harvest.png',
                  title: 'Greens',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FoodDetailsPage(
                                  title: 'Greens',
                                  icon: 'assets/food/harvest.png',
                                  cover: 'assets/chats/2.jpg',
                                )));
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
                  image: 'assets/food/drink.png',
                  title: 'Juice',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FoodDetailsPage(
                                  title: 'Juice',
                                  icon: 'assets/food/drink.png',
                                  cover: 'assets/chats/3.jpg',
                                )));
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: MoreMenuCard(
                  image: 'assets/food/fruits.png',
                  title: 'Fruits',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FoodDetailsPage(
                                  title: 'Fruits',
                                  icon: 'assets/food/fruits.png',
                                  cover: 'assets/chats/4.jpg',
                                )));
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
                  image: 'assets/food/maternity.png',
                  title: 'Expecting',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FoodDetailsPage(
                                  title: 'Expecting Mothers',
                                  icon: 'assets/food/maternity.png',
                                  cover: 'assets/chats/5.jpg',
                                )));
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: MoreMenuCard(
                  image: 'assets/food/baby-food.png',
                  title: 'Weaning',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FoodDetailsPage(
                                  title: 'Weaning',
                                  icon: 'assets/food/baby-food.png',
                                  cover: 'assets/chats/6.jpg',
                                )));
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
