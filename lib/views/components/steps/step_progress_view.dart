import 'package:flutter/material.dart';

class StepProgressView extends StatelessWidget {
  //height of the container
  final double _height;
//width of the container
  final double _width;
//container decoration
  final BoxDecoration decoration;
//list of texts to be shown for each step
  final int _steps;
//cur step identifier
  final int _curStep;
//active color
  final Color _activeColor;
//in-active color
  final Color _inactiveColor;
//dot radius
  final double _dotRadius;
//container padding
  final EdgeInsets padding;
//line height
  final double lineHeight;
//header textstyle
  final TextStyle _headerStyle;
  final String _title;

  const StepProgressView({
    Key key,
    @required int steps,
    @required int curStep,
    @required double height,
    @required double width,
    @required double dotRadius,
    @required Color activeColor,
    @required Color inactiveColor,
    @required TextStyle headerStyle,
    @required TextStyle stepsStyle,
    @required String title,
    this.decoration,
    this.padding,
    this.lineHeight = 2.0,
  })  : _steps = steps,
        _curStep = curStep,
        _height = height,
        _width = width,
        _dotRadius = dotRadius,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _headerStyle = headerStyle,
        _title = title,
        assert(curStep > 0 == true && curStep <= steps),
        assert(width > 0),
        assert(height >= 2 * dotRadius),
        assert(width >= dotRadius * 2 * steps),
        super(key: key);

  List<Widget> _buildDots() {
    var wids = <Widget>[];

    for (int i = 0; i < _steps; i++) {
      var circleColor =
          (i == 0 || _curStep > i) ? _activeColor : _inactiveColor;

      var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;

      wids.add(CircleAvatar(
        radius: _dotRadius,
        backgroundColor: circleColor,
      ));

      //add a line separator
      //0-------0--------0
      if (i != _steps - 1) {
        wids.add(Expanded(
            child: Container(
          height: lineHeight,
          color: lineColor,
        )));
      }
    }

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        height: this._height,
        width: this._width,
        decoration: this.decoration,
        child: Column(
          children: <Widget>[
            Container(
                child: Center(
                    child: RichText(
                        text: TextSpan(children: [
              TextSpan(
                text: (_curStep).toString(),
                style: _headerStyle.copyWith(
                  color: _activeColor, //this is always going to be active
                ),
              ),
              TextSpan(
                text: " / " + _steps.toString(),
                style: _headerStyle.copyWith(
                  color: _curStep == _steps ? _activeColor : _inactiveColor,
                ),
              ),
            ])))),
            Row(
              children: _buildDots(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _title,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
