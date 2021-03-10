import 'package:aunty_rafiki/models/recipe.dart';

import 'package:aunty_rafiki/views/components/cards/recipe_card.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:aunty_rafiki/views/pages/recipe_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  final List<Recipe> recipes;
  final String title;

  const RecipePage({Key key, @required this.recipes, @required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: recipes.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.7,
                ),
                Center(
                    child: NoItemTile(
                        icon: 'assets/recipe/diet.png',
                        title: 'No recipes of yet')),
              ],
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
              ),
              itemCount: recipes.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (BuildContext ctx, index) {
                return RecipeCard(
                  recipe: recipes[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RecipeDetailsPage(
                                  icon: 'assets/recipe/diet.png',
                                  recipe: recipes[index],
                                )));
                  },
                );
              }),
    );
  }
}
