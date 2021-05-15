import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:mi_card/components/utils/listItemModel.dart';

part 'formModel.g.dart';

@HiveType(typeId: 0)
class FormModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  @HiveField(0)
  double amountOfMoney = 100;
  @HiveField(1)
  String time;
  @HiveField(2)
  String motive;

  String email;

  ListItem timePair;
  ListItem motivePair;

  //@HiveField(3)
  Map<Key, String> mapForm = {
    Key("time"): "Not assigned",
    Key("motive"): "Not assigned"
  };

  FormModel({this.amountOfMoney, this.time, this.motive, this.mapForm});

  set formTimeAndMotive(Map<Key, String> mapForm) {
    time = mapForm[Key("time")];
    motive = mapForm[Key("motive")];
  }

  set formTime(Map<Key, String> mapForm) {
    time = mapForm[Key("time")];
  }

  set formMotive(Map<Key, String> mapForm) {
    motive = mapForm[Key("motive")];
  }

  //int getMotiveOrTime(Key key) {}

  String getText(String val) {
    final newVal = val.toString();
    switch (newVal) {
      case "[<'time'>]":
        {
          return time;
        }
        break;
      case "[<'motive'>]":
        {
          return motive;
        }
        break;
      default:
        return 'Not assigned';
        break;
    }
  }

  void itemsChanged() {
    notifyListeners();
  }

  void updateMap(Key key, String val) {
    mapForm[key] = val;
  }

  //FormModel({this.amountOfMoney, this.time, this.motive});

}

class StateFormModel extends ChangeNotifier {
  double numberOfItemsCompleted = 1;
  Map<Key, bool> drawers = Map<Key, bool>();
  final arr = List<Key>();
  //StateFormModel({this.numberOfItemsCompleted});

  set number(double newNumber) {
    numberOfItemsCompleted = newNumber;
    notifyListeners();
  }

  numbher(Key key, String newValue) {
    if (arr.contains(key) == true) {
      if (newValue == "Not assigned") {
        print(arr.contains(key));
        arr.remove(key);
        numberOfItemsCompleted -= 1;
        notifyListeners();
      }
    }

    if (arr.contains(key) == false) {
      if (newValue != "Not assigned") {
        arr.add(key);
        numberOfItemsCompleted += 1;
        notifyListeners();
      }
    }
  }

  double get getNumber {
    return numberOfItemsCompleted;
  }
}
