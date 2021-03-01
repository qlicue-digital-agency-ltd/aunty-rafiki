import 'package:aunty_rafiki/models/food.dart';
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
            Image.network(
              food.cover,
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
                food.title + " AND TO PREPARE",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "How to be informed, not overwhelmed, during a pandemic",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Marzipan cookie jelly brownie biscuit. Lemon drops jelly-o soufflé sesame snaps gingerbread caramels. Oat cake apple pie sweet roll tootsie roll jelly-o lollipop. Powder dragée muffin candy canes donut cheesecake danish. Halvah chupa chups icing muffin apple pie gummi bears chocolate cake. Carrot cake cotton candy muffin chupa chups tart cotton candy wafer. Pudding chocolate cake chocolate cake oat cake jelly beans jelly. Dessert sesame snaps candy canes pastry candy canes marzipan chocolate bar soufflé tootsie roll. Sesame snaps caramels caramels pudding halvah cupcake sesame snaps marshmallow. Liquorice wafer halvah topping lemon drops carrot cake. Icing gummies jelly-o croissant pudding. Powder liquorice danish.\nGummi bears cheesecake dessert. Jelly beans cookie soufflé danish marzipan tootsie roll liquorice lemon drops. Soufflé tart croissant jujubes. Cotton candy sesame snaps pastry wafer. Ice cream croissant cotton candy jujubes pie oat cake biscuit. Liquorice biscuit liquorice carrot cake liquorice caramels. Halvah donut carrot cake jelly beans cake cookie. Halvah dragée fruitcake dragée sweet oat cake tiramisu marshmallow. Ice cream marshmallow pudding. Jujubes pudding bear claw ice cream dragée. Marzipan chupa chups cupcake muffin cotton candy pudding dessert donut biscuit. Wafer marshmallow apple pie tiramisu. Caramels soufflé apple pie gummi bears pudding cookie. Sweet jujubes chupa chups.\nChocolate cake bear claw cupcake sesame snaps gingerbread jelly-o ice cream dragée. Powder caramels cotton candy croissant jelly toffee carrot cake bonbon. Biscuit brownie tootsie roll cookie sesame snaps brownie cookie. Toffee jelly-o topping candy canes pie topping cookie carrot cake topping. Powder croissant soufflé jelly gummi bears gingerbread gingerbread bear claw macaroon. Cookie chupa chups pie chocolate cake pudding tart sweet roll jelly beans. Gummi bears macaroon candy canes. Fruitcake sesame snaps gummi bears jujubes icing sweet icing brownie. Cupcake dessert jelly jelly jelly. Lemon drops cotton candy oat cake chupa chups. Jelly-o carrot cake cotton candy donut danish candy canes. Lollipop icing icing fruitcake gummies marshmallow croissant tart fruitcake. Muffin lemon drops sugar plum sweet roll chocolate. Pastry cotton candy marshmallow sugar plum.\nTiramisu tootsie roll sweet liquorice tiramisu cupcake chocolate chupa chups sweet roll. Apple pie chocolate cake cake pudding gummi bears wafer lemon drops oat cake cookie. Macaroon topping gummi bears. Fruitcake gummi bears bear claw caramels. Brownie caramels icing chocolate cake marshmallow tart jelly beans pudding. Ice cream jujubes chocolate bar. Gummi bears brownie topping gummi bears cake sugar plum lemon drops croissant macaroon. Chocolate jujubes dessert caramels muffin jujubes gummi bears. Ice cream powder lemon drops. Jujubes toffee toffee jelly-o ice cream cotton candy soufflé caramels. Dessert pastry liquorice cheesecake gingerbread candy. Chocolate cake donut jelly-o sweet roll bear claw chocolate bar soufflé bear claw sugar plum. Bear claw bonbon danish sesame snaps chupa chups.\nCandy canes gummi bears biscuit marzipan. Icing sugar plum sweet roll jelly chocolate cake jelly candy jelly lemon drops. Jelly beans tiramisu dessert icing candy jujubes cake gummies. Lemon drops carrot cake wafer dragée ice cream lemon drops. Gummies tootsie roll jelly beans jelly cheesecake gummies bonbon biscuit donut. Macaroon carrot cake chocolate bar donut pudding. Bear claw candy croissant ice cream sweet muffin chocolate. Macaroon pie tootsie roll caramels candy. Cotton candy croissant chocolate cake halvah chupa chups topping bear claw toffee. Powder liquorice pastry candy canes powder sweet oat cake. Donut sweet soufflé jelly-o. Lollipop lemon drops pie chupa chups dessert tiramisu bonbon jujubes cupcake. Jelly jelly-o apple pie danish gingerbread brownie.",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ]),
        )

        //  NoItemTile(icon: icon, title: 'No\t' + title + '\tcontent'),
        );
  }
}
