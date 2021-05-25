import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mi_card/Screens/Login/login_screen.dart';
import 'package:mi_card/Screens/Signup/signup_screen.dart';
import 'package:mi_card/Screens/Welcome/components/background.dart';
import 'package:mi_card/components/rounded_button.dart';
import 'package:mi_card/constants.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Welcome to \n',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextSpan(
                  text: "MyloansApp",
                  style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[900])),
            ])),
            SizedBox(height: size.height * 0.02),
            SvgPicture.asset(
              "assets/icons/welcomesvg.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Login",
              color: kPrimaryColor,
              textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
                text: "Sign up",
                color: Colors.lightBlue[800],
                textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
