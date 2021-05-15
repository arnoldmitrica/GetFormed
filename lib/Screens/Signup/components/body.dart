import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mi_card/Screens/Login/login_screen.dart';
import 'package:mi_card/Screens/Signup/components/background.dart';
import 'package:mi_card/Screens/Signup/components/or_divider.dart';
import 'package:mi_card/Screens/Signup/components/social_icon.dart';
import 'package:mi_card/components/already_have_an_account_check.dart';
import 'package:mi_card/components/rounded_button.dart';
import 'package:mi_card/components/rounded_input_field.dart';
import 'package:mi_card/components/rounded_password_field.dart';
import 'package:mi_card/components/utils/checkCredentials.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign UP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                username.text = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password.text = value;
              },
            ),
            RoundedButton(
              text: "Sign up",
              press: () {
                _navigator();
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                }),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // navigator(String username, String password) async {
  //   setCredential(username, password).then((_) {
  //     print("User signed up with user $username and $password");
  //   });
  // }

  _navigator() async {
    if (username.text.length != 0 || password.text.length != 0) {
      try {
        await getCrdntialsForSignup(username.text);
        Fluttertoast.showToast(
          msg: "You logged in!",
          gravity: ToastGravity.BOTTOM,
          fontSize: 25,
          textColor: Colors.white,
          backgroundColor: Colors.green[300],
          //timeInSecForIosWeb: 2,
        );
      } catch (err) {
        print(err.toString());
        Fluttertoast.showToast(
          msg: err.toString(),
          gravity: ToastGravity.BOTTOM,
          fontSize: 20,
          textColor: Colors.white,
          backgroundColor: Colors.pink[400],
          //timeInSecForIosWeb: 2,
        );
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              content: Text(
                "username or password \ncan't be empty",
                style: TextStyle(fontSize: 16.0),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      print("Login pressed");
                    },
                    child: Text("Ok"))
              ],
            );
          });
    }
  }
}
