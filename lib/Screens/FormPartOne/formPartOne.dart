import 'package:flutter/material.dart';
import 'package:mi_card/components/utils/formModel.dart';
import 'package:mi_card/components/utils/listItemModel.dart';
import 'package:provider/provider.dart';
import 'components/slider_widget.dart';
import 'components/time_drawer.dart';
import 'package:hive/hive.dart';

class FormPartOne extends StatefulWidget {
  FormPartOne({Key key}) : super(key: key);

  @override
  _FormPartOneState createState() => _FormPartOneState();
}

class _FormPartOneState extends State<FormPartOne> {
  double itemsCompleted = 0;
  double calculateProgress() {
    return 0.4 / (itemsCompleted);
  }

  Widget getMoneySlider() {
    return CustomSlider.value(50);
  }

  Widget getTimeDrawer() {
    final List<ListItem> list = [
      ListItem("Not assigned", 0),
      ListItem("1 month", 1),
      ListItem("3 months", 3),
      ListItem("6 months", 6),
      ListItem("1 year", 12),
    ];
    return ItemDrawer.list(
      list,
      "Select the time period:",
      Key("time"),
    );
  }

  Widget getMotiveDrawer() {
    final List<ListItem> list = [
      ListItem("Not assigned", 1),
      ListItem("Medical", 2),
      ListItem("Facturi", 3),
      ListItem("Mancare", 4),
      ListItem("Datorie", 5),
      ListItem("Taxe", 6),
      ListItem("Investitii", 7),
      ListItem("Alte cheltuieli", 8),
    ];
    return ItemDrawer.list(
      list,
      "Select a motive:",
      Key("motive"),
    );
  }

  Widget getSubmitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: TextButton(
            child: Text("Validate".toUpperCase()),
            style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue[600]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue[600])))),
            onPressed: () => print("Form part one")),
      ),
    );
  }

  List<Widget> renderForm() {
    return [
      getMoneySlider(),

      getTimeDrawer(),

      getMotiveDrawer(),

      SizedBox(height: 20),

      getSubmitButton(),
      // getMotive()
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double topBottom = 80;
    double maxCompleted = 0.4 / 3;
    return MaterialApp(
      theme: buildThemeDataLightMode(),
      darkTheme: buildThemeDataDarkMode(),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: topBottom),
              child: MultiProvider(
                providers: [
                  //ChangeNotifierProvider(create: (context) => FormModel()),
                  ChangeNotifierProvider(create: (context) => StateFormModel())
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "First validation",
                      style: TextStyle(
                          fontFamily: 'Newsreader',
                          fontSize: topBottom - 20,
                          color: Colors.blueGrey[700]),
                    ),
                    Consumer<StateFormModel>(
                      builder: (context, model, child) {
                        final double val = model.getNumber;

                        return LinearProgressIndicator(
                          minHeight: 5,
                          value: val * 0.4 / 3,
                        );
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Completed(maxCompleted: maxCompleted),
                    SizedBox(
                      height: 70,
                    ),
                    //style: Theme.of(context).textTheme.headline2),
                    formPartOneBody(),
                  ],
                ),
              ),
              decoration: boxDecorationCustom(Colors.blue[100]),
            ),
          ],
        ),
      ),
    );
  }

  ThemeData buildThemeDataDarkMode() {
    return ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.cyan[600],
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue[100]),
        headline6: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.italic,
            color: Colors.blue[100]),
        bodyText2: TextStyle(
            fontSize: 14.0, fontFamily: 'Newsreader', color: Colors.blue[400]),
        bodyText1: TextStyle(
            fontSize: 14.0, fontFamily: 'Newsreader', color: Colors.blue[400]),
      ),
    );
  }

  ThemeData buildThemeDataLightMode() {
    return ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.cyan[600],
      //fontFamily: 'Newsreader',
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue[100]),
        headline2: TextStyle(fontSize: 32, fontFamily: 'Newsreader'),
        headline6: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.italic,
            color: Colors.blue[100]),
        bodyText2: TextStyle(
            fontSize: 14.0, fontFamily: 'Newsreader', color: Colors.black),
        bodyText1: TextStyle(
            fontSize: 14.0, fontFamily: 'Newsreader', color: Colors.black87),
      ),
    );
  }

  Column formPartOneBody() {
    Box formBox = Hive.box('tudo1');

    //formBox.clear()

    print(formBox.keys);

    // Provider.of<FormModel>(context, listen: false).amountOfMoney =
    //     newFormModel.amountOfMoney;
    // Provider.of<FormModel>(context, listen: false)
    //     .updateMap(Key("time"), newFormModel.time);
    // Provider.of<FormModel>(context, listen: false)
    //     .updateMap(Key("motive"), newFormModel.motive);

    return Column(
        //alignment: Alignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: boxDecorationCustom(Colors.white),
            padding: EdgeInsets.symmetric(vertical: 25.0),
            //color: Colors.blue[100],
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: renderForm(),
              ),
            ),
          ),
        ]);
  }

  BoxDecoration boxDecorationCustom(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 12,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }
}

class Completed extends StatefulWidget {
  const Completed({
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
    return Consumer<StateFormModel>(
      builder: (context, model, child) {
        final double val = model.getNumber;
        final double newVal = (val * 0.4 / 3 * 100).roundToDouble();
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
