import 'package:flutter/material.dart';
import 'package:mi_card/Screens/FormPartTwo/formPartTwo.dart';
import 'package:mi_card/Screens/HomeScreen/home_screen.dart';
import 'package:mi_card/components/utils/formModel.dart';
import 'package:mi_card/constants.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter<FormModel>(FormModelAdapter());

  String email = sharedPreferences.get('email');
  if (email == null) {
    print("tudo1 does not exist");
    sharedPreferences.setString('email', 'tudo1');
    email = 'tudo1';
  }
  var form = await Hive.openBox(email);

  // var newForm = FormModel();
  // newForm.amountOfMoney = 700;
  // newForm.motive = "Facturi";
  // newForm.time = "6 months";

  //form.putAt(0, newForm);
  print('main ${form.keys}');
  //form.add(newForm);

  runApp(ChangeNotifierProvider(
      create: (context) => FormModel(), child: MyApp(email: email)));
}

class MyApp extends StatefulWidget {
  final String email;

  const MyApp({Key key, this.email})
      : assert(email != null),
        super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //Hive.registerAdapter(FormModel());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myLoans Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      //home: FormPartOne(),
      home: FutureBuilder(
        future: Hive.openBox(widget.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return FormPartTwo();
          }
          // Although opening a Box takes a very short time,
          // we still need to return something before the Future completes.
          else
            return Scaffold();
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
