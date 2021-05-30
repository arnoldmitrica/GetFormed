import 'package:flutter/material.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:provider/provider.dart';

class Completed extends StatefulWidget {
  Completed({
    Key key,
    @required this.maxCompleted,
  }) : super(key: key);

  final double maxCompleted;

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ViewModel>(
      builder: (context, form, child) {
        final double val = form.model.values["completed"] / 13 * 100;
        final double newVal = val.roundToDouble();
        return Text(
          "completed: $newVal%",
          style: TextStyle(
              fontFamily: 'Newsreader',
              fontSize: 20,
              color: Colors.blueGrey[700]),
        );
      },
    );
  }
}
