import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mi_card/Screens/FormPartOne/formPartOne.dart';
import 'package:mi_card/Screens/ListForms/ListViewForms.dart';
import 'package:mi_card/Screens/Login/login_screen.dart';
import 'package:mi_card/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggedInHomeScreen extends StatefulWidget {
  const LoggedInHomeScreen({Key key, @required this.email}) : super(key: key);

  final String email;

  @override
  State<LoggedInHomeScreen> createState() => _LoggedInHomeScreenState();
}

class _LoggedInHomeScreenState extends State<LoggedInHomeScreen> {
  bool loggedIn = true;

  @override
  Widget build(BuildContext mainContext) {
    Size size = MediaQuery.of(mainContext).size;
    return FutureBuilder(
      future: Hive.openBox(widget.email),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError)
            return Text(snapshot.error.toString());
          else
            return buildScaffold(mainContext, size, context);
        } else
          return Scaffold();
      },
    );
  }

  Scaffold buildScaffold(
      BuildContext mainContext, Size size, BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 10,
              top: 40,
              child: Text("Hi, ${widget.email}",
                  style: TextStyle(
                      fontFamily: 'Newsreader',
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700]))),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      mainContext,
                      MaterialPageRoute(
                          builder: (context) =>
                              FormPartOne(widget.email, null)));
                },
                child: Container(
                    height: size.height * 0.38,
                    child: Padding(
                      padding: EdgeInsets.only(left: 48, right: 48, top: 48),
                      child: SvgPicture.asset('assets/icons/addform2.svg'),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      mainContext,
                      MaterialPageRoute(
                          builder: (context) =>
                              FormModelItemsList(widget.email)));
                },
                child: Container(
                    height: size.height * 0.37,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 35, right: 35, bottom: 0),
                      child: SvgPicture.asset('assets/icons/seemyforms4.svg'),
                    )),
              ),
              InkWell(
                onTap: () {
                  loggedIn = false;
                  setState(() {});
                  logOutUser()
                      .then((value) => Navigator.of(context).pushAndRemoveUntil(
                            // the new route
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen(),
                            ),

                            // this function should return true when we're done removing routes
                            // but because we want to remove all other screens, we make it
                            // always return false
                            (Route route) => false,
                          ));
                },
                child: Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 0),
                        child: Container(
                            height: size.height * 0.25,
                            child:
                                SvgPicture.asset('assets/icons/logout2.svg'))),
                    Positioned(
                        left: MediaQuery.of(context).size.width / 2,
                        bottom: 30,
                        child: loggedIn == false
                            ? Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor),
                                  ),
                                ),
                                color: Colors.white.withOpacity(0.8),
                              )
                            : Container(width: 0.0, height: 0.0)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> logOutUser() {
    return Future.delayed(Duration(seconds: 2), () async {
      setState(() {
        loggedIn = false;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
    });
  }
}
