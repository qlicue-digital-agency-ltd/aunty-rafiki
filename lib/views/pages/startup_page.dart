import 'dart:async';
import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartupPage extends StatefulWidget {
  @override
  StartupPageState createState() => StartupPageState();
}

class StartupPageState extends State<StartupPage>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  AuthProvider _authProvider;

  ///start time...
  startTime() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _authProvider = Provider.of<AuthProvider>(context, listen: false);
    });
    return Timer(Duration(seconds: 5), navigationPage);
  }

  void navigationPage() async {
    final _config = await _authProvider.appConfigurationStep;
    if (_config == Configuration.Non) {
      Navigator.of(context).pushReplacementNamed(onboardingPage);
    } else if (_config == Configuration.Terms) {
      Navigator.of(context).pushReplacementNamed(termsConditionPage);
    } else if (_config == Configuration.SignUp) {
      Navigator.of(context).pushReplacementNamed(loginPage);
    } else if (_config == Configuration.Profile) {
      Navigator.of(context).pushReplacementNamed(createProfilePage);
    } else if (_config == Configuration.Done) {
      Navigator.of(context).pushReplacementNamed(landingPage);
    } else {
      Navigator.pushReplacementNamed(context, createProfilePage);
    }
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('AUNT RAFIKI FROM QLICUE'),
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Image.asset(
                    'assets/icons/aunty_rafiki.png',
                    height: 25.0,
                    fit: BoxFit.scaleDown,
                  ))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
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
