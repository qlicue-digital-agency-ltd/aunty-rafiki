import 'package:aunty_rafiki/views/components/picker/custom_number_picker.dart';
import 'package:aunty_rafiki/views/components/steps/step_progress_view.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_text_field.dart';
import 'package:flutter/material.dart';

class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage>
    with TickerProviderStateMixin {
  int _weeksOfPregnancy = 4;
  int _yearOfBirth = 1988;
  final _steps = 4;

  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 150.0;

  Color _activeColor = Colors.pink;

  Color _inactiveColor = Colors.grey;

  TextStyle _headerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  int _curPage = 1;

  GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();

  TextEditingController _nameEditingController = TextEditingController();

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
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150.0,
                child: StepProgressView(
                  steps: _steps,
                  curStep: _curPage,
                  height: _stepProgressViewHeight,
                  width: MediaQuery.of(context).size.width,
                  dotRadius: _stepCircleRadius,
                  activeColor: _activeColor,
                  inactiveColor: _inactiveColor,
                  headerStyle: _headerStyle,
                  stepsStyle: _stepStyle,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(
                    top: 48.0,
                    left: 24.0,
                    right: 24.0,
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (i) {
                    setState(() {
                      _curPage = i + 1;
                    });
                    print(_curPage);
                  },
                  children: <Widget>[
                    Form(
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
                          SlideTransition(
                            position: _animation,
                            transformHitTests: true,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      color: Colors.pink[400],
                                      child: Text(
                                        'Save'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      onPressed: () {
                                        if (_nameFormKey.currentState
                                            .validate()) {
                                          print('save the data');
                                        } else {
                                          print('Issue the data');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: CustomNumberPicker(
                        title: 'How many weeks pregnant are you?',
                        currentValue: _weeksOfPregnancy,
                        onChanged: (value) {
                          setState(() {
                            _weeksOfPregnancy = value;
                          });
                        },
                        miniValue: 4,
                        maxValue: 43,
                      ),
                    ),
                    Container(
                      child: CustomNumberPicker(
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
                    ),
                    Container(
                      color: Colors.pink,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
