import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: buildThemeDataLightMode(),
      home: FutureBuilder(
          future: checkUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else {
                //final em =
                //final email = ${dow}
                return LoggedInHomeScreen(size: size, email: email);
              }
            }
            return CircularProgressIndicator();
          }),
    );
  }

  Future<String> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString('email') ?? 'You';
    email = status;
    return status;
    // if (status) {
    //   Navigation.pushReplacement(context, "/Home");
    // } else {
    //   Navigation.pushReplacement(context, "/Login");
    // }
  }
}

class LoggedInHomeScreen extends StatelessWidget {
  const LoggedInHomeScreen({Key key, @required this.size, @required this.email})
      : super(key: key);

  final double size;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Positioned(
            left: 10,
            top: 40,
            child: Text("Hi, $email",
                style: TextStyle(
                    fontFamily: 'Newsreader',
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[700]))),
        Column(
          children: [
            InkWell(
              onTap: () {
                print("dadsada");
              },
              child: Container(
                  height: size * 0.38,
                  child: Padding(
                    padding: EdgeInsets.only(left: 48, right: 48, top: 48),
                    child: SvgPicture.asset('assets/icons/addform2.svg'),
                  )),
            ),
            Container(
                height: size * 0.37,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 0),
                  child: SvgPicture.asset('assets/icons/seemyforms4.svg'),
                )),
            Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SvgPicture.asset('assets/icons/logout2.svg'))),
          ],
        ),
      ]),
    );
  }
}

ThemeData buildThemeDataLightMode() {
  return ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Colors.lightBlue[800],
    accentColor: Colors.cyan[600],
    //fontFamily: 'Newsreader',
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.blue[100]),
      headline2: TextStyle(fontSize: 32, fontFamily: 'Newsreader'),
      headline6: TextStyle(
          fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.blue[100]),
      bodyText2: TextStyle(
          fontSize: 14.0, fontFamily: 'Newsreader', color: Colors.black),
      bodyText1: TextStyle(
          fontSize: 14.0, fontFamily: 'Newsreader', color: Colors.black87),
    ),
  );
}

// FutureBuilder(
//         future: Hive.openBox(widget.email),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError)
//               return Text(snapshot.error.toString());
//             else
//               return HomeScreen();
//           }
//           // Although opening a Box takes a very short time,
//           // we still need to return something before the Future completes.
//           else
//             return Scaffold();
//         },
//       )
