import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mi_card/Screens/FormPartOne/components/time_drawer.dart';
import 'package:mi_card/Screens/FormPartTwo/components/getImage.dart';
import 'package:mi_card/Screens/FormPartTwo/components/location.dart';
import 'package:mi_card/components/completedWidget.dart';
import 'package:mi_card/components/rounded_input_field.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:mi_card/components/utils/listItemModel.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class FormPartTwo extends StatefulWidget {
  final int index;
  final String email;
  FormPartTwo(this.email, this.index, {Key key}) : super(key: key);

  @override
  _FormPartTwoState createState() => _FormPartTwoState(email, index);
}

class _FormPartTwoState extends State<FormPartTwo> {
  Box<dynamic> box;
  int index;
  String email;
  _FormPartTwoState(this.email, this.index, {this.box}) {
    if (index != null) {}
  }

  Random random = Random();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController cnp = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController income = TextEditingController();

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    cnp.dispose();
    jobTitle.dispose();
    super.dispose();
  }

  bool workGroup = false;

  double itemsCompleted = 0;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double topBottom = 70;
    double maxCompleted;
    final size = MediaQuery.of(context).size.height;
    box = Hive.box(email);
    return buildScaffoldPartTwo(size, topBottom, maxCompleted);
  }

  Scaffold buildScaffoldPartTwo(
      double size, double topBottom, double maxCompleted) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: size / 10),
        child: GestureDetector(
          onTap: () {
            //FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
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
                          "Second validation",
                          style: TextStyle(
                              fontFamily: 'Newsreader',
                              fontSize: topBottom - 20,
                              color: Colors.blueGrey[700]),
                        ),
                        Consumer<ViewModel>(
                          builder: (context, form, child) {
                            final double val =
                                form.model.values["completed"] / 12;

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
                          height: 50,
                        ),
                        Form(key: _formKey, child: formPartTwoBody()),
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

  Column formPartTwoBody() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: boxDecorationCustom(Colors.white),
        padding: EdgeInsets.symmetric(vertical: 25.0),
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
      getFirstNameButton(),
      getLastName(),
      getCNP(),
      getStareCivila(),
      getWorkingStatus(),
      getTitleJob(),
      getDomain(),
      getEarnings(),
      getImage(),
      getLocation(),
      SizedBox(
        height: 35,
      ),
      getNavigationButtons()
    ];
  }

  Widget getFirstNameButton() {
    return Builder(builder: (firstNamecontext) {
      return FocusScope(
        onFocusChange: (focus) {
          if (focus == false) {
            Provider.of<ViewModel>(firstNamecontext, listen: false)
                .updateCompletePercentState("firstName", firstName.text);
          }
        },
        child: RoundedInputField(
            initialValue:
                Provider.of<ViewModel>(firstNamecontext, listen: false)
                    .model
                    .values["firstName"],
            func: nameValidator,
            hintText: "First Name",
            onChanged: (value) {
              firstName.text = value;
            }),
      );
    });
  }

  Function(String) nameValidator = (String name) {
    if (name.isNotEmpty && name.length > 2) {
      return null;
    } else {
      return "Name is invalid";
    }
  };

  Widget getLastName() {
    return Builder(builder: (lastNamecontext) {
      return FocusScope(
        onFocusChange: (focus) {
          if (focus == false) {
            Provider.of<ViewModel>(lastNamecontext, listen: false)
                .updateCompletePercentState("lastName", lastName.text);
          }
        },
        child: RoundedInputField(
            initialValue: Provider.of<ViewModel>(lastNamecontext, listen: false)
                .model
                .values["lastName"],
            func: nameValidator,
            hintText: "Last Name",
            onChanged: (value) {
              lastName.text = value;
            }),
      );
    });
  }

  Widget getCNP() {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size / 8),
      child: Container(
          alignment: Alignment.centerLeft,
          child: Builder(builder: (cnpContext) {
            cnp.text = Provider.of<ViewModel>(cnpContext, listen: false)
                .model
                .values["cnp"];
            return FocusScope(
              onFocusChange: (focus) {
                if (focus == false) {
                  Provider.of<ViewModel>(cnpContext, listen: false)
                      .updateCompletePercentState("cnp", cnp.text);
                }
              },
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.length == 13) {
                    return null;
                  } else {
                    return "Enter a 13-digit number CNP";
                  }
                },
                controller: cnp,
                decoration: InputDecoration(labelText: "CNP"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
            );
          })),
    );
  }

  Widget getStareCivila() {
    final List<ListItem> list = [
      ListItem("Single", 1),
      ListItem("Married", 2),
      ListItem("Divorced", 3),
    ];
    return ItemDrawer.list(
      list,
      "Select your status:",
      keyMap: "status",
    );
  }

  Widget getWorkingStatus() {
    final List<ListItem> list = [
      ListItem("Yes", 1),
      ListItem("No", 2),
    ];
    return ItemDrawer.list(
      list,
      "Do you work?",
      keyMap: "work",
    );
  }

  Widget getNavigationButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      getValidateButton(),
      getCloseButton(),
    ]);
  }

  Padding getValidateButton() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width / 8),
      child: Builder(builder: (buildercontext) {
        return Container(
          child: Consumer<ViewModel>(builder: (context, form, child) {
            return TextButton(
                child: Text("Validate".toUpperCase()),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(
                            left: size.width / 8,
                            right: size.width / 8,
                            top: 15,
                            bottom: 15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue[600]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue[600])))),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState.validate() &&
                      form.model.values["completed"] == 13) {
                    if (random.nextInt(10) < 6) {
                      showDialog(context, "Your current form was not accepted");
                    } else {
                      showDialog(context, "Your current form is accepted");
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Fill all the form.",
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 20,
                        textColor: Colors.white,
                        backgroundColor: Colors.pink[400]);
                  }
                });
          }),
        );
      }),
    );
  }

  Widget getCloseButton() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: size.width / 8),
      child: Container(
        child: TextButton(
            child: Text("Close".toUpperCase()),
            style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple[200]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.purple[200])))),
            onPressed: () {
              showCloseDialog(context, "Go back to first validation or exit.");
            }),
      ),
    );
  }

  Future<dynamic> showDialog(BuildContext context, String text, {int val}) {
    return showPlatformDialog(
      context: context,
      builder: (dialogContext) {
        if (val != null && val <= 12 && val >= 11) {
          return BasicDialogAlert(
            title: Text("Make sure to upload image and location."),
            content: Text(text),
            actions: <Widget>[
              BasicDialogAction(
                title: Text("Close"),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        } else {
          if (val == null) {
            return BasicDialogAlert(
              title: Text("Form result"),
              content: Text(text),
              actions: <Widget>[
                BasicDialogAction(
                  title: Text("Close dialog"),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
                BasicDialogAction(
                  title: Text("Back to homescreen"),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        }
      },
    );
  }

  Future<dynamic> showCloseDialog(BuildContext context, String text) {
    return showPlatformDialog(
      context: context,
      builder: (dialogContext) => BasicDialogAlert(
        title: Text("Exit form."),
        content: Text(text),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Back"),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.pop(context);
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

  Widget getTitleJob() {
    return Builder(builder: (titleContext) {
      return FocusScope(
        onFocusChange: (focus) {
          if (focus == false) {
            Provider.of<ViewModel>(titleContext, listen: false)
                .updateCompletePercentState("jobTitle", jobTitle.text);
          }
        },
        child: RoundedInputField(
            initialValue: Provider.of<ViewModel>(titleContext, listen: false)
                .model
                .values["jobTitle"],
            func: nameValidator,
            hintText: "Your job title",
            onChanged: (value) {
              jobTitle.text = value;
            }),
      );
    });
  }

  Widget getDomain() {
    final List<ListItem> list = [
      ListItem("Muncitori tehnicieni", 1),
      ListItem("Office jobs", 2),
      ListItem("Inginerie", 3),
      ListItem("IT Telecom", 4),
      ListItem("Servicii", 5),
      ListItem("Finante", 6),
      ListItem("Marketing", 7),
      ListItem("Sanatate", 8),
      ListItem("Institutii sau profesii libere", 9),
      ListItem("Vanzari", 10),
    ];
    return ItemDrawer.list(
      list,
      "Select your field domain:",
      keyMap: "domain",
    );
  }

  Widget getEarnings() {
    final size = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size / 8),
        child: Container(
            alignment: Alignment.centerLeft,
            child: Builder(builder: (incomeContext) {
              income.text = Provider.of<ViewModel>(incomeContext, listen: false)
                  .model
                  .values["income"];

              return FocusScope(
                onFocusChange: (value) {
                  if (value == false) {
                    Provider.of<ViewModel>(incomeContext, listen: false)
                        .updateCompletePercentState("income", income.text);
                  }
                },
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (double.tryParse('$value') !=
                        null) if (double.tryParse('$value') < 1000) {
                      return "Income must be greater than 1000";
                    } else
                      return null;
                  },
                  controller: income,
                  onChanged: (value) => income.text = value,
                  decoration: InputDecoration(
                      labelText: "What is your monthly earnings? (RON)"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ], // Only numbers can be entered
                ),
              );
            })));
  }

  Widget getImage() {
    return GetImage();
  }

  Widget getLocation() {
    return GetLocation();
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
