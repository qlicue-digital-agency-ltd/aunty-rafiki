import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  const NameScreen(
      {Key key, @required int currentPage, @required Function changePage})
      : _currentPage = currentPage,
        _changePage = changePage,
        super(key: key);
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> with TickerProviderStateMixin {
  TextEditingController _nameEditingController = TextEditingController();

  GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();

  AnimationController _controller;

  Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 2.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Form(
        key: _nameFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'What is your name?',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            IconTextField(
              icon: Icons.person,
              textEditingController: _nameEditingController,
              title: 'Full Name',
              validator: (val) {
                if (val.isEmpty)
                  return 'Enter the your name';
                else
                  return null;
              },
            ),
            Spacer(),
            CustomRaisedButton(
                title: 'Next',
                onPressed: () {
                  if (_nameFormKey.currentState.validate()) {
                    print('save the data');
                    _authProvider
                        .updateUsername(
                            displayName: _nameEditingController.text,
                            hasProfile: false)
                        .then((value) {
                      if (!value) {
                        widget._changePage(widget._currentPage + 1);
                        _authProvider.setConfigurationStep =
                            Configuration.NameScreenStepDone;
                      }
                    });
                  } else {
                    print('Issue the data');
                  }
                }),
            SizedBox(
              height: 40,
            ),
          ],
        ));
  }
}
