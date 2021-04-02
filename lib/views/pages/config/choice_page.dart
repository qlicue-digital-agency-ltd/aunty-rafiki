import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:flutter/material.dart';

class ChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to Aunty Rafiki')),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'How can we help you?',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              width: double.infinity,
              child: TextButton(
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(25)),
                // padding: const EdgeInsets.symmetric(vertical: 16),
                // color: Colors.pink[400],
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          text: "I'm pregnant\n"),
                      TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          text: 'want to track my condition'),
                    ])),
                onPressed: () {
                  Navigator.of(context).pushNamed(stepsPage);
                  //_authProvider.setConfigurationStep = Configuration.Terms;
                },
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
            //textColor: Colors.pink,
            onPressed: () {},
            child: Text('Sign In & Restore Data')),
      ),
    );
  }
}
