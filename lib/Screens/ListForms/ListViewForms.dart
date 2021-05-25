import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mi_card/Screens/FormPartOne/formPartOne.dart';
import 'package:mi_card/Screens/FormPartTwo/formPartTwo.dart';
import 'package:mi_card/Screens/ListForms/listcard.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:mi_card/components/utils/formModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    Size size = MediaQuery.of(context).size;
    final formBox = Hive.box(email);

    return Scaffold(
        appBar: AppBar(
          title: Text("Forms list"),
        ),
        body: formBox.isNotEmpty
            ? Container(
                child: ValueListenableBuilder(
                    valueListenable: Hive.box(email).listenable(),
                    builder: (valueContext, form, child) {
                      return ListView.builder(
                          itemCount: formBox.length,
                          itemBuilder: (BuildContext listContext, int index) {
                            final form = formBox.getAt(index) as FormModel;
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
                                  child: Container(
                                    constraints:
                                        BoxConstraints(minWidth: size.width),
                                    child: FutureBuilder(
                                        future: _checkPhoto(
                                            form.values["imagePath"]),
                                        builder: (listViewBuilderContext,
                                            AsyncSnapshot<bool> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            print(
                                                "snapshotData is ${snapshot.data}");
                                            if (snapshot.hasError)
                                              return Text(
                                                  snapshot.error.toString());
                                            else {
                                              return snapshot.data == true
                                                  ? Cardlist(
                                                      form,
                                                      File(form
                                                          .values["imagePath"]))
                                                  : Cardlist(form, null);
                                            }
                                          } else
                                            return CircularProgressIndicator();
                                        }),
                                  ),
                                ));
                          });
                    }),
              )
            : Center(child: SvgPicture.asset("assets/icons/noimage.svg")));
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
                : Container(
                    width: 0,
                    height: 0,
                  ),
            BasicDialogAction(
              title: Text("Close"),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
            ),
          ]),
    );
  }

  Future<bool> _checkPhoto(String path) async {
    print("path is $path");
    return path == null ? Future.value(false) : await File(path).exists();
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
