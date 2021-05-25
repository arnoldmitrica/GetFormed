import 'package:flutter/material.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:provider/provider.dart';

typedef void StateCallback(int val);

class CustomSlider extends StatefulWidget {
  //CustomSlider({Key key}) : super(key: key);
  final int division;
  final double startingvalue;
  final ValueChanged<double> valueChanged;
  CustomSlider.value(this.division, this.startingvalue, this.valueChanged);

  @override
  _CustomSliderState createState() =>
      _CustomSliderState(division, startingvalue);
}

class _CustomSliderState extends State<CustomSlider> {
  double finalvalue = 100;
  bool completed = false;

  int division;
  _CustomSliderState(this.division, this.finalvalue);

  @override
  Widget build(BuildContext context) {
    //return Builder(builder: (sliderContext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Select the amount of money: $finalvalue',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Slider(
          value: finalvalue,
          divisions: 18,
          min: 100,
          max: 1000,
          activeColor: Colors.red,
          label: '$finalvalue',
          onChangeEnd: widget.valueChanged,
          onChanged: (value) => setState(
            () {
              this.finalvalue = value;
            },
          ),
        ),
      ],
    );
    // });
  }
}
