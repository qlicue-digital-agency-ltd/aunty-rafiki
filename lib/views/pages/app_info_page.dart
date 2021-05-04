import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:flutter/material.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0,
        title: Text(
          Languages.of(context).labelAboutUs,
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  'Auntie Rafiki, V 1.0',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'By Qlicue Digital Agency LTD',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/icons/aunty_rafiki.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'This product is developed and maintained and owned by Qlicue Digital Agency LTD in  patnership with Maternity Call',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
