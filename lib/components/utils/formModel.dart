//import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:mi_card/components/utils/listItemModel.dart';

part 'formModel.g.dart';

@HiveType(typeId: 0)
class FormModel {
  /// Internal, private state of the cart.
  @HiveField(0)
  Map<String, dynamic> values = {
    "amountOfMoney": null,
    "firstName": "",
    "lastName": "",
    "time": null,
    "motive": null,
    "cnp": "",
    "status": null,
    "work": null,
    "jobTitle": null,
    "domain": null,
    "income": '',
    "location": null,
    "completed": 0,
    "imagePath": null,
    "accepted": false,
    "index": null
  };

  @HiveField(1)
  File image;
}
