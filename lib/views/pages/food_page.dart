import 'package:aunty_rafiki/providers/food_provider.dart';
import 'package:aunty_rafiki/views/components/cards/more_menu_card.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';

import 'package:aunty_rafiki/views/pages/recipe_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _foodProvider = Provider.of<FoodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Food',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _foodProvider.isFetchingFoodData
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.7,
                ),
                Center(child: Loading()),
              ],
            )
          : _foodProvider.availableFoods.isEmpty
              ? Center(
                  child: NoItemTile(
                  icon: 'assets/access/diet.png',
                  title: 'NO food posts yet',
                  onTap: () {
                    _foodProvider.fetchFoods();
                  },
                ))
              : RefreshIndicator(
                  onRefresh: () {
                    return _foodProvider.fetchFoods();
                  },
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemCount: _foodProvider.availableFoods.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (BuildContext ctx, index) {
                        return MoreMenuCard(
                          isLocal: false,
                          title: _foodProvider.availableFoods[index].title,
                          image: _foodProvider
                                  .availableFoods[index].images.isNotEmpty
                              ? _foodProvider
                                  .availableFoods[index].images.last.url
                              : null,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RecipePage(
                                          food: _foodProvider
                                              .availableFoods[index],
                                          title: _foodProvider
                                              .availableFoods[index].title,
                                        )));
                          },
                        );
                      }),
                ),
    );
  }
}
