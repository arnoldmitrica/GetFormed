import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:provider/provider.dart';

class RadioW extends StatefulWidget {
  RadioW(this.models, this.groupName, {Key key}) : super(key: key);
  final List<String> models;
  final String groupName;

  List<RadioModel> initialize() {
    return List<RadioModel>.generate(models.length, (index) {
      return index == 0
          ? RadioModel(models[index], index + 1, true)
          : RadioModel(models[index], index + 1, false);
    });
  }

  @override
  _RadioState createState() {
    return _RadioState(initialize(), groupName);
  }
}

class _RadioState extends State<RadioW> {
  String groupValue;
  String _groupName;
  int _value2 = 0;

  List<RadioModel> _radioModels;

  _RadioState(this._radioModels, this._groupName);

  Widget makeRadioTiles() {
    List<Widget> list = new List<Widget>();
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    list.add(Text(_groupName));

    for (int i = 0; i < _radioModels.length; i++) {
      list.add(
        Expanded(
          child:
              //Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Consumer<ViewModel>(builder: (context, form, child) {
            return RadioListTile(
              value: _radioModels[i].index,
              groupValue: _value2,
              selected: _radioModels[i].selected,
              onChanged: (val) {
                setState(() {
                  for (int i = 0; i < _radioModels.length; i++) {
                    _radioModels[i].selected = false;
                    //print('_radioModels[i] ${_radioModels[i].text}');
                    //print('val $val');
                  }
                  _value2 = val;
                  _radioModels[i].selected = true;
                  print(_groupName);
                  print('_radioModels[i] ${_radioModels[i].text}');
                  print('val $val');
                  //form.model.values["status"] == null
                  form.updateCompletePercentState(
                      _groupName, {val - 1: _radioModels[i].text});
                });
              },
              activeColor: Colors.purple,
              controlAffinity: ListTileControlAffinity.platform,
              title: Text(
                ' ${_radioModels[i].text}',
                style: TextStyle(
                  color: _radioModels[i].selected ? Colors.black : Colors.grey,
                  fontWeight: _radioModels[i].selected
                      ? FontWeight.bold
                      : FontWeight.w400,
                  fontSize: MediaQuery.of(context).size.width / 34,
                ),
              ),
            );
          }),
          //]),
        ),
      );
    }

    Widget widget = Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: list,
    ));
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[makeRadioTiles()]);
  }
}

class RadioModel {
  String text;
  int index;
  bool selected = false;
  RadioModel(this.text, this.index, this.selected);
}
