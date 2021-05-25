import 'package:flutter/material.dart';
import 'package:mi_card/Screens/HomeScreen/loggedInHomeScreen.dart';
import 'package:mi_card/Screens/Signup/signup_screen.dart';
import 'package:mi_card/Screens/splashScreen.dart';
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
    return Scaffold(
      body: FutureBuilder(
          future: checkUser(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else {
                if (snapshot.data == "You") {
                  return DescriptionScreen();
                }
                //final data = snapshot.data;
                //final em =
                //final email = ${dow}
                return LoggedInHomeScreen(email: email);
              }
            }
            return CircularProgressIndicator();
          }),
    );
  }

  Future<String> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') == null ? 'You' : prefs.getString('email');
    return email;
  }
}
