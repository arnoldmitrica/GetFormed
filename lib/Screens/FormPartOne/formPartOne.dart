import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mi_card/Screens/FormPartTwo/formPartTwo.dart';
import 'package:mi_card/components/completedWidget.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:mi_card/components/utils/listItemModel.dart';
import 'package:provider/provider.dart';
import 'components/slider_widget.dart';
import 'components/time_drawer.dart';
import 'package:hive/hive.dart';

class FormPartOne extends StatefulWidget {
  //final Box<dynamic> box;
  final int index;
  final String email;
  FormPartOne(this.email, this.index, {Key key}) : super(key: key);

  @override
  _FormPartOneState createState() => _FormPartOneState(email, index);
}

class _FormPartOneState extends State<FormPartOne> {
  final _formKey = GlobalKey<FormState>();
  int index;
  Box<dynamic> box;
  String email;
  _FormPartOneState(this.email, this.index, {this.box});
  double itemsCompleted = 0;

  //TextEditingController moneySlider = Text

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final double topBottom = 80;
    double maxCompleted;
    box = Hive.box(email);
    return buildScaffold(topBottom, maxCompleted);
  }

  Scaffold buildScaffold(double topBottom, double maxCompleted) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: topBottom),
            child: ChangeNotifierProvider(
              create: (context) => ViewModel(box, index),
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
                  Consumer<ViewModel>(
                    builder: (context, form, child) {
                      final double val =
                          form.model.values["completed"] / 12 >= 1
                              ? 1
                              : form.model.values["completed"] / 12;
                      maxCompleted = val * 100;

                      return LinearProgressIndicator(
                        minHeight: 5,
                        value: val,
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
                  Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: formPartOneBody()),
                ],
              ),
            ),
            decoration: boxDecorationCustom(Colors.blue[100]),
          ),
        ],
      ),
    );
  }

  Column formPartOneBody() {
    Box formBox = Hive.box(email);

    print(formBox.keys);

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

  Widget getMoneySlider() {
    return Builder(builder: (sliderContext) {
      final startingvalueString =
          Provider.of<ViewModel>(sliderContext, listen: false)
              .model
              .values["amountOfMoney"];
      double startingvalue;
      startingvalueString == null
          ? startingvalue = 100
          : startingvalue = double.parse(startingvalueString);
      return CustomSlider.value(50, startingvalue, (value) {
        Provider.of<ViewModel>(sliderContext, listen: false)
            .updateCompletePercentState("amountOfMoney", value);
      });
    });
  }

  Widget getTimeDrawer() {
    final List<ListItem> list = [
      ListItem("1 month", 1),
      ListItem("3 months", 3),
      ListItem("6 months", 6),
      ListItem("1 year", 12),
    ];
    return ItemDrawer.list(
      list,
      "Select the time period:",
      keyMap: "time",
    );
  }

  Widget getMotiveDrawer() {
    final List<ListItem> list = [
      ListItem("Medical", 1),
      ListItem("Facturi", 2),
      ListItem("Mancare", 3),
      ListItem("Datorie", 4),
      ListItem("Taxe", 5),
      ListItem("Investitii", 6),
      ListItem("Alte cheltuieli", 7),
    ];
    return ItemDrawer.list(
      list,
      "Select a motive:",
      keyMap: "motive",
    );
  }

  Widget getSubmitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.0),
      child: Builder(
        builder: (buttoncontext) {
          return Container(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  child: Text("Validate".toUpperCase()),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[600]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue[600])))),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      FocusScope.of(context).unfocus();
                      index =
                          Provider.of<ViewModel>(buttoncontext, listen: false)
                              .finalIndex;
                      final double money = double.parse(Provider.of<ViewModel>(
                                  buttoncontext,
                                  listen: false)
                              .model
                              .values["amountOfMoney"])
                          .round()
                          .toDouble();
                      final time =
                          Provider.of<ViewModel>(buttoncontext, listen: false)
                              .model
                              .values["time"];
                      final timeDouble = timeDrawer[time];
                      final value = (money / timeDouble) * 1.1;
                      showContinueDialog(context,
                          "Do you confirm a monthly rate of $value?", index);
                      //Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please complete all the forms",
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 20,
                        textColor: Colors.white,
                        backgroundColor: Colors.pink[400],
                        //timeInSecForIosWeb: 2,
                      );
                    }
                  }));
        },
      ),
    );
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

  Future<dynamic> showContinueDialog(
      BuildContext continueContext, String text, int finalindex) {
    return showPlatformDialog(
      context: continueContext,
      builder: (dialogContext) => BasicDialogAlert(
        title: Text("Accept the terms?"),
        content: Text(text),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Yes. Continue"),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormPartTwo(email, finalindex)));
            },
          ),
          BasicDialogAction(
            title: Text("Close"),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Map<String, int> timeDrawer = {
    "1 month": 1,
    "3 months": 3,
    "6 months": 6,
    "1 year": 12
  };
}
