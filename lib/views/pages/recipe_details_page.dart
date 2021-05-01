import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/models/recipe.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({Key key, @required this.icon, @required this.recipe})
      : super(key: key);

  final String icon;

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(recipe.title, style: TextStyle(color: Colors.black)),
      
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            recipe.images.isEmpty
                ? Image.asset(
                    'assets/images/img_not_available.jpeg',
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      child: Loading(),
                      height: size.height / 3,
                      width: size.width,
                      padding: EdgeInsets.all(70.0),
                      decoration: BoxDecoration(
                        color: greyColor2,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Material(
                      child: Image.asset(
                        'assets/images/img_not_available.jpeg',
                        height: size.height / 3,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                    ),
                    imageUrl: recipe.images.last.url,
                    height: size.height / 3,
                    width: size.width,
                    fit: BoxFit.fill,
                  ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                recipe.title,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              title: Text('Ingredients'),
              subtitle: Text('All you need to prepare this recipe'),
              trailing: Text(
                "🥗",
                style: TextStyle(fontSize: 50),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${recipe.ingredients}',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: Text('How to Prepare'),
              subtitle: Text('Prepare this in 15 minutes'),
              trailing: Text(
                "👩‍🍳",
                style: TextStyle(fontSize: 50),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${recipe.howToPrepare}',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: Text('Alternative recipes'),
              subtitle: Text('Substitute recipes for this recipe'),
              trailing: Text(
                "🥙",
                style: TextStyle(fontSize: 50),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${recipe.alternativeFood}',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
          ]),
        )

        //  NoItemTile(icon: icon, title: 'No\t' + title + '\tcontent'),
        );
  }
}
