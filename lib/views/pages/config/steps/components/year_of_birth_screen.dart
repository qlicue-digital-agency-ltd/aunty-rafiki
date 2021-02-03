import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/dialog/custom_dialog_box.dart';
import 'package:aunty_rafiki/views/components/picker/custom_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearOfBirthScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  const YearOfBirthScreen(
      {Key key, @required int currentPage, @required Function changePage})
      : _currentPage = currentPage,
        _changePage = changePage,
        super(key: key);

  @override
  _YearOfBirthScreenState createState() => _YearOfBirthScreenState();
}

class _YearOfBirthScreenState extends State<YearOfBirthScreen> {
  int _yearOfBirth = 1988;

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        CustomNumberPicker(
          title: 'What year were you born?',
          subtitle:
              'Telling us your age will help us give us precise information',
          currentValue: _yearOfBirth,
          onChanged: (value) {
            setState(() {
              _yearOfBirth = value;
            });
          },
          miniValue: 1931,
          maxValue: 2008,
        ),
        Spacer(),
        CustomRaisedButton(
            title: 'Next',
            onPressed: () {
              if (DateTime.now().year - _yearOfBirth >= 18) {
                _authProvider
                    .updateYearOfBirth(yearOfBirth: _yearOfBirth)
                    .then((value) {
                  if (!value) {
                    widget._changePage(widget._currentPage + 1);
                    _authProvider.setConfigurationStep =
                        Configuration.YearOfBirthScreenStepDone;
                  }
                });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        title: "NOT OF AGE",
                        descriptions:
                            "This App is to be used by people above the age of 18+",
                        text: "CLOSE",
                        textClose: "",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      );
                    });
              }
            }),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
