import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mi_card/Screens/ListForms/ListViewForms.dart';

class ModelItems extends StatefulWidget {
  final String email;
  ModelItems(this.email, {Key key})
      : assert(email != null),
        super(key: key);

  @override
  _ModelItemsState createState() => _ModelItemsState(email);
}

class _ModelItemsState extends State<ModelItems> {
  String email;
  _ModelItemsState(this.email);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Your last forms"),
        ),
        body: FutureBuilder(
          future: Hive.openBox(email),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return FormModelItemsList(email);
            }
            // Although opening a Box takes a very short time,
            // we still need to return something before the Future completes.
            else
              return Scaffold();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
