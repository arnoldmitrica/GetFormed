import 'package:flutter/material.dart';

typedef void StateCallback(int val);

class CustomSlider extends StatefulWidget {
  //CustomSlider({Key key}) : super(key: key);
  final int division;
  CustomSlider.value(this.division);

  @override
  _CustomSliderState createState() => _CustomSliderState(division);
}

class _CustomSliderState extends State<CustomSlider> {
  double value = 100;
  bool completed = false;

  int division;
  _CustomSliderState(this.division);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Select the amount of money:',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Slider(
          value: value,
          divisions: 18,
          min: 100,
          max: 1000,
          activeColor: Colors.red,
          label: '$value',
          onChanged: (value) => setState(() {
            this.value = value;
            this.completed = true;
          }),
        ),
      ],
    );
  }
}
