//import 'dart:html';

import 'dart:io';

import 'package:hive/hive.dart';

part 'formModel.g.dart';

@HiveType(typeId: 0)
class FormModel {
  /// Internal, private state of the cart.
  @HiveField(0)
  Map<String, dynamic> values = {
    "amountOfMoney": "100",
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
    "completed": 1,
    "imagePath": null,
    "accepted": false,
    "index": null
  };

  @HiveField(1)
  String image;
}
