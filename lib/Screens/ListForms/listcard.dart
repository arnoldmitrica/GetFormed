import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mi_card/Screens/ListForms/itemcard.dart';
import 'package:mi_card/components/utils/formModel.dart';

class Cardlist extends StatelessWidget {
  final FormModel form;
  final File image;
  const Cardlist(this.form, this.image, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(
                    maxHeight: size.height / 5, minHeight: size.height / 8),
                child: image != null
                    ? Image.file(image)
                    : SvgPicture.asset("assets/icons/noimage.svg"),
              ),
              Wrap(
                children: [
                  ItemCard(List<String>.from(
                      [form.values["firstName"], form.values["lastName"]])),
                  form.values["motive"] != null
                      ? ItemCard((List<String>.from(
                          ["Motive of", form.values["motive"]])))
                      : ItemCard(["No motive"]),
                  form.values["time"] != null
                      ? ItemCard(["For ", form.values["time"]])
                      : ItemCard(["No time selected"]),
                  form.values["location"] != null
                      ? ItemCard(["At ", form.values["location"]])
                      : ItemCard(["Location not specified"]),
                  form.values["jobTitle"] != null
                      ? ItemCard([form.values["jobTitle"]])
                      : Container(width: 0, height: 0)
                ],
              ),
            ],
          ),
        ));
  }
}
