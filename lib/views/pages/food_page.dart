import 'dart:io';

import 'package:aunty_rafiki/providers/food_provider.dart';
import 'package:aunty_rafiki/views/components/cards/more_menu_card.dart';
import 'package:aunty_rafiki/views/pages/food_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _foodProvider = Provider.of<FoodProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Food')),
      body: _foodProvider.isFetchingFoodData
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.7,
                ),
                Center(
                    child: Platform.isAndroid
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.pink),
                          )
                        : CupertinoActivityIndicator()),
              ],
            )
          : Column(children: [
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
                        onTap: _foodProvider.availableFoods.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => FoodDetailsPage(
                                              icon: 'assets/food/diet.png',
                                              food: _foodProvider
                                                  .availableFoods[0],
                                            )));
                              },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: MoreMenuCard(
                        image: 'assets/food/harvest.png',
                        title: 'Greens',
                        onTap: _foodProvider.availableFoods.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => FoodDetailsPage(
                                              icon: 'assets/food/harvest.png',
                                              food: _foodProvider
                                                  .availableFoods[1],
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
                        onTap: _foodProvider.availableFoods.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => FoodDetailsPage(
                                              icon: 'assets/food/drink.png',
                                              food: _foodProvider
                                                  .availableFoods[2],
                                            )));
                              },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: MoreMenuCard(
                        image: 'assets/food/fruits.png',
                        title: 'Fruits',
                        onTap: _foodProvider.availableFoods.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => FoodDetailsPage(
                                              icon: 'assets/food/fruits.png',
                                              food: _foodProvider
                                                  .availableFoods[3],
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
                        onTap: _foodProvider.availableFoods.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => FoodDetailsPage(
                                              icon: 'assets/food/maternity.png',
                                              food: _foodProvider
                                                  .availableFoods[4],
                                            )));
                              },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: MoreMenuCard(
                        image: 'assets/food/baby-food.png',
                        title: 'Weaning',
                        onTap: _foodProvider.availableFoods.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => FoodDetailsPage(
                                              icon: 'assets/food/baby-food.png',
                                              food: _foodProvider
                                                  .availableFoods[5],
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
