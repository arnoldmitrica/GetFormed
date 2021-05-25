import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mi_card/Screens/FormPartOne/formPartOne.dart';
import 'package:mi_card/Screens/FormPartTwo/formPartTwo.dart';
import 'package:mi_card/Screens/ListForms/listcard.dart';
import 'package:mi_card/components/utils/formModel.dart';
import 'package:flutter/services.dart';

class FormModelItemsList extends StatefulWidget {
  final String email;
  FormModelItemsList(this.email) : assert(email != null);

  @override
  _FormModelItemsListState createState() => _FormModelItemsListState(email);
}

class _FormModelItemsListState extends State<FormModelItemsList> {
  String email;
  _FormModelItemsListState(this.email);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formBox = Hive.box(email);

    return Scaffold(
        appBar: AppBar(
          title: Text("Forms list"),
        ),
        body: Container(
            child: formBox.isNotEmpty
                ? ListView.builder(
                    itemCount: formBox.length,
                    itemBuilder: (BuildContext context, int index) {
                      final form = formBox.getAt(index) as FormModel;
                      File image;
                      try {
                        final val = File(form.values["imagePath"]).existsSync();
                        if (val == false) {
                          image = null;
                          throw ErrorDescription("No image");
                        } else {
                          image = File(form.values["imagePath"]);
                        }
                      } catch (err) {
                        print(err.toString());
                      }
                      //final form = formBox[index];
                      return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            setState(() {
                              formBox.deleteAt(index);
                            });
                          },
                          background: Container(
                            color: Colors.red,
                          ),
                          child: InkWell(
                            onTap: () => showFormValidationDialog(
                                context, form.values["completed"], index),
                            child: Cardlist(form, image),
                          ));
                    })
                : Center(child: SvgPicture.asset("assets/icons/noimage.svg"))));
  }

  Future<dynamic> showFormValidationDialog(
      BuildContext context, int formCompleted, int index) {
    return showPlatformDialog(
      context: context,
      builder: (dialogContext) => BasicDialogAlert(
          title: Text("Open form."),
          content: Text("Choose what validation section to open"),
          actions: <Widget>[
            BasicDialogAction(
              title: Text("First validation"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormPartOne(email, index)));
              },
            ),
            formCompleted >= 4
                ? BasicDialogAction(
                    title: Text("Second validation"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormPartTwo(email, index)));
                    },
                  )
                : BasicDialogAction(),
            BasicDialogAction(
              title: Text("Close"),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
            ),
          ]),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    return Rect.fromLTWH(0, 0, 200, 100);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
  }
}
