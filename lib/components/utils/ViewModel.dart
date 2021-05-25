import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mi_card/components/utils/formModel.dart';

class ViewModel extends ChangeNotifier {
  FormModel model;
  Box<dynamic> box;
  bool isItNewIndex;
  int finalIndex;
  Map<String, dynamic> incompleteState = {
    "amountOfMoney": null,
    "firstName": null,
    "lastName": null,
    "time": null,
    "motive": null,
    "cnp": null,
    "status": null,
    "work": null,
    "jobTitle": null,
    "domain": null,
    "income": null,
    "location": null,
    "completed": 0,
    "imagePath": null,
    "accepted": false,
    "index": null
  };

  ViewModel(this.box, this.finalIndex) {
    if (box != null && finalIndex != null) {
      model = box.getAt(finalIndex) as FormModel;
      if (model != null) {
        _updateForm(model);
      } else {
        model = FormModel();
        model.values.addAll(incompleteState);
      }
    }
    if (finalIndex == null) {
      model = FormModel();
      model.values.addAll(incompleteState);
      _updateDB();
      model.values["index"] = box.keys.length - 1;
      finalIndex = box.keys.length - 1;
    }
  }

  _updateForm(FormModel newViewModel) {
    model = newViewModel;
  }

  updateCompletePercentState(String keyMap, dynamic value) {
    if (model.values[keyMap] == null && value != null) {
      model.values[keyMap] = value.toString();
      model.values["completed"] += 1;
    }
    if (model.values[keyMap] != null && value == null) {
      model.values[keyMap] = null;
      model.values["completed"] -= 1;
    }
    if (model.values[keyMap] != null && value != null) {
      model.values[keyMap] = value.toString();
    }
    notifyListeners();
    _updateDB();
  }

  _updateDB() async {
    if (finalIndex == null) {
      box.add(model);
      //box.put(finalIndex, map);
      finalIndex = box.length - 1;
    } else {
      try {
        await box.putAt(finalIndex, model);
      } catch (e) {
        box.add(model);
        finalIndex = box.length - 1;
      }
    }
  }

  Future<void> updateDbAndListener() async {
    _updateDB();
    notifyListeners();
  }
}
