import 'package:flutter/material.dart';
import 'package:mi_card/Screens/HomeScreen/home_screen.dart';
import 'package:mi_card/components/utils/formModel.dart';
import 'package:mi_card/constants.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter<FormModel>(FormModelAdapter());

  // form.clear();
  // form.deleteAll(form.keys);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'myLoans Auth',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Newsreader'),
        home: HomeScreen());
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
