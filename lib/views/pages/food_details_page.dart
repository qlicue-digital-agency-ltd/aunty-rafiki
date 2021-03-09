import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/models/food.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({Key key, @required this.icon, @required this.food})
      : super(key: key);

  final String icon;

  final Food food;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(food.title),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CachedNetworkImage(
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
                  'images/img_not_available.jpeg',
                  height: size.height / 3,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                clipBehavior: Clip.hardEdge,
              ),
              imageUrl: food.cover,
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
                food.title,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              title: Text('Ingredients'),
              subtitle: Text('All you need to prepare this food'),
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
                    '1. Macaroon cookie tiramisu wafer liquorice pudding.\n\n2. Carrot cake candy cookie.\n\n3. Chocolate bar jujubes jelly-o brownie gummi bears tiramisu sesame snaps oat cake.\n\n4. Tiramisu bear claw gingerbread cotton candy muffin.\n\n5. Oat cake chocolate cake danish bear claw sweet roll soufflé fruitcake jelly halvah. Tiramisu gingerbread sesame snaps sugar plum.\n\n6. Chupa chups candy brownie macaroon donut tiramisu.',
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
                    'Macaroon cookie tiramisu wafer liquorice pudding. Carrot cake candy cookie. Chocolate bar jujubes jelly-o brownie gummi bears tiramisu sesame snaps oat cake. Tiramisu bear claw gingerbread cotton candy muffin.\n\nLiquorice oat cake jelly bear claw candy chocolate bar oat cake chocolate cake cotton candy. Oat cake chocolate cake danish bear claw sweet roll soufflé fruitcake jelly halvah. Tiramisu gingerbread sesame snaps sugar plum. Chupa chups candy brownie macaroon donut tiramisu.',
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
              title: Text('Alternative foods'),
              subtitle: Text('Substitute foods for this food'),
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
                    'Macaroon cookie tiramisu wafer liquorice pudding. Carrot cake candy cookie. Chocolate bar jujubes jelly-o brownie gummi bears tiramisu sesame snaps oat cake. Tiramisu bear claw gingerbread cotton candy muffin.\n\nLiquorice oat cake jelly bear claw candy chocolate bar oat cake chocolate cake cotton candy. Oat cake chocolate cake danish bear claw sweet roll soufflé fruitcake jelly halvah. Tiramisu gingerbread sesame snaps sugar plum. Chupa chups candy brownie macaroon donut tiramisu.',
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
