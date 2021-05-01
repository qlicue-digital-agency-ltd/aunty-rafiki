import 'package:aunty_rafiki/models/food.dart';

import 'package:aunty_rafiki/views/components/cards/recipe_card.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:aunty_rafiki/views/pages/recipe_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  final Food food;
  final String title;

  const RecipePage({Key key, @required this.food, @required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(title, style: TextStyle(color: Colors.black))),
      body: food.recipes.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.7,
                ),
                Center(
                    child: NoItemTile(
                        isLocal: !food.images.isNotEmpty,
                        icon: food.images.isNotEmpty
                            ? food.images.last.url
                            : 'assets/access/diet.png',
                        title: 'No recipes of yet')),
              ],
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
              ),
              itemCount: food.recipes.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (BuildContext ctx, index) {
                return RecipeCard(
                  recipe: food.recipes[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RecipeDetailsPage(
                                  icon: 'assets/recipe/diet.png',
                                  recipe: food.recipes[index],
                                )));
                  },
                );
              }),
    );
  }
}
