import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mi_card/components/rounded_button.dart';
import 'package:mi_card/components/rounded_input_field.dart';
import 'package:mi_card/components/utils/formModel.dart';
import 'package:mi_card/components/utils/locationDataModel.dart';
import 'package:mi_card/constants.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';

class FormPartTwo extends StatefulWidget {
  FormPartTwo({Key key}) : super(key: key);

  @override
  _FormPartOneState createState() => _FormPartOneState();
}

class _FormPartOneState extends State<FormPartTwo> {
  File _image;

  String _location;

  Location _location;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController cnp = TextEditingController();
  TextEditingController jobTitle = TextEditingController();

  String marritalStatus = "Single";

  double itemsCompleted = 0;

  double calculateProgress() {
    return 0.4 / (itemsCompleted);
  }

  Widget getFirstNameButton() {
    return RoundedInputField(
        hintText: "First Name",
        onChanged: (value) {
          firstName.text = value;
        });
  }

  Widget getLastName() {
    return RoundedInputField(
      hintText: "Last name",
      onChanged: (value) {
        lastName.text = value;
      },
    );
  }

  Widget getCNP() {
    return RoundedInputField(
      hintText: "CNP",
      onChanged: (value) {
        cnp.text = value;
      },
    );
  }

  Widget getStareCivila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Marrital status:"),
        SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Single"),
              Radio(
                  value: "Single",
                  groupValue: marritalStatus,
                  onChanged: (val) {
                    marritalStatus = val;
                    setState(() {});
                  }),
              Text("Married"),
              Radio(
                  value: "Married",
                  groupValue: marritalStatus,
                  onChanged: (val) {
                    marritalStatus = val;
                    setState(() {});
                  }),
              Text("Divorced"),
              Radio(
                  value: "Divorced",
                  groupValue: marritalStatus,
                  onChanged: (val) {
                    marritalStatus = val;
                    setState(() {});
                  }),
            ],
          ),
        )
      ],
    );
  }

  Widget getWorkingStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Are you working?"),
        SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Yes"),
              Radio(
                  value: true,
                  groupValue: marritalStatus,
                  onChanged: (val) {
                    marritalStatus = val;
                    setState(() {});
                  }),
              Text("No"),
              Radio(
                  value: false,
                  groupValue: marritalStatus,
                  onChanged: (val) {
                    marritalStatus = val;
                    setState(() {});
                  }),
            ],
          ),
        )
      ],
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
            onPressed: () => print("Form part two")),
      ),
    );
  }

  Widget getTitleJob() {
    return RoundedInputField(
        hintText: "Your job title",
        onChanged: (value) {
          jobTitle.text = value;
        });
  }

  Widget getEarnings() {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size / 8),
      child: Container(
        alignment: Alignment.centerLeft,
        child: TextField(
          decoration: InputDecoration(
              labelText: "What is your monthly earnings? (RON)"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ], // Only numbers can be entered
        ),
      ),
    );
  }

  Widget getImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            _getFromGallery();
          },
          child: Text("Upload image"),
        ),
        _image == null ? Text('No image selected.') : Image.file(_image),
      ],
    );
  }

  Widget getLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            _getFromGallery();
          },
          child: Text("Get location"),
        ),
        _image == null ? Text('No image selected.') : Image.file(_image),
      ],
    );
  }

  List<Widget> renderForm() {
    return [
      getFirstNameButton(),
      getLastName(),
      getCNP(),
      getStareCivila(),
      getWorkingStatus(),
      getTitleJob(),
      getEarnings(),
      getImage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double topBottom = 70;
    double maxCompleted = 0.4 / 3;
    final size = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: buildThemeDataLightMode(),
      darkTheme: buildThemeDataDarkMode(),
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: size / 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: topBottom),
                  child: MultiProvider(
                    providers: [
                      //ChangeNotifierProvider(create: (context) => FormModel()),
                      ChangeNotifierProvider(
                          create: (context) => StateFormModel())
                    ],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Second validation",
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
                          height: 50,
                        ),
                        //style: Theme.of(context).textTheme.headline2),
                        formPartOneBody(),
                      ],
                    ),
                  ),
                  decoration: boxDecorationCustom(Colors.deepPurple[200]),
                ),
              ],
            ),
          ),
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
      primaryColor: Colors.deepPurple[300],
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

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 100,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    }
  }

  _getLocation() async {
    Location location = Location.

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
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
