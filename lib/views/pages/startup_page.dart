import 'dart:async';
import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartupPage extends StatefulWidget {
  @override
  StartupPageState createState() => new StartupPageState();
}

class StartupPageState extends State<StartupPage>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  HostipalBagProvider _hospitalBagProvider;
  AuthProvider _authProvider;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    //Navigator.of(context).pushReplacementNamed(landingPage);

    final _config = await _authProvider.appConfigurationStep;
    if (_config == Configuration.Non) {
      Navigator.of(context).pushReplacementNamed(onboardingPage);
    } else if (_config == Configuration.Terms) {
      Navigator.of(context).pushReplacementNamed(termsConditionPage);
    } else if (_config == Configuration.Done) {
      Navigator.of(context).pushReplacementNamed(homePage);
      _hospitalBagProvider.loadItems();
    } else {
      Navigator.pushReplacementNamed(context, createProfilePage);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _hospitalBagProvider =
          Provider.of<HostipalBagProvider>(context, listen: false);
      _authProvider = Provider.of<AuthProvider>(context, listen: false);
    });

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('AUNT RAFIKI FROM QLICUE'),
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: new Image.asset(
                    'assets/icons/aunty_rafiki.png',
                    height: 25.0,
                    fit: BoxFit.scaleDown,
                  ))
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/icons/aunty_rafiki.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
