import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mi_card/components/utils/formModel.dart';

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
    print('ListView ${formBox.keys}');

    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: formBox.length,
          itemBuilder: (BuildContext context, int index) {
            final form = formBox.get(index) as FormModel;
            //final form = formBox[index];
            return ListTile(
              title: Text('motive: ${form.motive}'),
              subtitle: Text('time: ${form.time}'),
              trailing: Text('money: ${form.amountOfMoney}'),
            );
          },
        ),
      ),
    );
  }
}
