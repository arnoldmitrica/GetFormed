import 'package:flutter/material.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:mi_card/components/utils/listItemModel.dart';
import 'package:provider/provider.dart';

class ItemDrawer extends StatefulWidget {
  final List<ListItem> list;
  final String description;
  final String keyMap;
  //ItemDrawer({Key key}) : super(key: key);
  ItemDrawer.list(this.list, this.description, {this.keyMap});

  @override
  _ItemDrawerState createState() =>
      _ItemDrawerState(list, description, keyMap: keyMap);
}

class _ItemDrawerState extends State<ItemDrawer> {
  List<ListItem> listItems;
  String description;
  String keyMap;
  String _selectedValue;

  _ItemDrawerState(this.listItems, this.description, {this.keyMap});
  List<ListItem> _dropDownItems;

  //String _selectedItem;

  void initState() {
    super.initState();
    _dropDownItems = listItems;
    _selectedValue =
        Provider.of<ViewModel>(context, listen: false).model.values[keyMap];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 8),
              child: Builder(
                builder: (drawerContext) {
                  //print('formModelValueskeyMap ${Provider.of<ViewModel>(drawerContext, listen = false).model.values[keyMap]}');
                  return DropdownButtonFormField<String>(
                    hint: Text(description),
                    isExpanded: true,

                    value: _selectedValue, //_selectedItem,
                    items: _dropDownItems.map((item) {
                      return DropdownMenuItem(
                        value: item.name,
                        child: Text(item.name,
                            style: Theme.of(context).textTheme.bodyText2),
                      );
                    }).toList(),
                    validator: (value) => value == null ? '$description' : null,
                    onChanged: (newValue) {
                      var value =
                          Provider.of<ViewModel>(drawerContext, listen: false)
                              .model
                              .values[keyMap];

                      //value[value.keys.first] = newValue;

                      var item = listItems
                          .firstWhere((element) => (element.name == newValue));
                      print('timeDrawer item ${item.name} and ${item.value}');

                      value = item.name;
                      print('timeDrawer value $value');
                      Provider.of<ViewModel>(drawerContext, listen: false)
                          .updateCompletePercentState(keyMap, value);
                      _selectedValue = value;
                    },
                  );
                },
              ),
            ),
          ),
        ]);
  }
}
