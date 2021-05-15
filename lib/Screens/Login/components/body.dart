import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mi_card/Screens/Login/components/background.dart';
import 'package:mi_card/Screens/Signup/signup_screen.dart';
import 'package:mi_card/components/already_have_an_account_check.dart';
import 'package:mi_card/components/rounded_button.dart';
import 'package:mi_card/components/rounded_input_field.dart';
import 'package:mi_card/components/rounded_password_field.dart';
import 'package:mi_card/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mi_card/components/utils/checkCredentials.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();
  bool checkValue = false;
  SharedPreferences sharedPreferences;

  bool isLoading = false;

  Future<void> handleSignIn() async {
    setState(() {
      isLoading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    var isLoadingFuture = Future.delayed(Duration(seconds: 2), () {
      return false;
    });
    isLoadingFuture.then((response) {
      setState(() {
        isLoading = response;
      });
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getCredential();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.03,
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
              text: "LOGIN",
              press: () => _navigator(),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  )
                : Container(),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _navigator() async {
    if (username.text.length != 0 || password.text.length != 0) {
      try {
        await getCrdntialsForLogin(username.text);
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
