import 'package:flutter/material.dart';
import 'package:mi_card/components/utils/formModel.dart';
import 'package:mi_card/components/utils/listItemModel.dart';
import 'package:provider/provider.dart';

class ItemDrawer extends StatefulWidget {
  final List<ListItem> list;
  final String description;
  final Key key;
  //ItemDrawer({Key key}) : super(key: key);
  ItemDrawer.list(this.list, this.description, this.key);

  @override
  _ItemDrawerState createState() =>
      _ItemDrawerState(list, description, key: key);
}

class _ItemDrawerState extends State<ItemDrawer> {
  List<ListItem> listItems;
  String description;
  Key key;
  //String _selectedValue;

  _ItemDrawerState(this.listItems, this.description, {this.key});
  List<ListItem> _dropDownItems;

  //String _selectedItem;

  void initState() {
    super.initState();
    _dropDownItems = listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Consumer<FormModel>(
              builder: (context, form, child) {
                return DropdownButton<String>(
                  hint: Text("Select time period:"),
                  isExpanded: true,

                  value: form.mapForm[key], //_selectedItem,
                  items: _dropDownItems.map((item) {
                    return DropdownMenuItem(
                      value: item.name,
                      child: Text(item.name,
                          style: Theme.of(context).textTheme.bodyText2),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      form.mapForm[key] = newValue;
                      //form.motivePair.
                      //form.time = newValue;
                      //_selectedItem = form.getText(key.toString());
                      Provider.of<FormModel>(context, listen: false)
                          .updateMap(key, newValue);

                      Provider.of<StateFormModel>(context, listen: false)
                          .numbher(key, newValue);
                    });
                  },
                );
              },
            ),
          ),
        ]);
  }
}
