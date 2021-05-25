import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mi_card/Screens/HomeScreen/loggedInHomeScreen.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController username = TextEditingController();

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedInputField(
                    func: nameValidator,
                    hintText: "Your username",
                    onChanged: (value) {
                      username.text = value;
                    },
                  ),
                  RoundedPasswordField(
                    func: passValidator,
                    onChanged: (value) {
                      _password.text = value;
                    },
                  ),
                  RoundedPasswordField(
                    func: (String value) {
                      if (value.isEmpty) {
                        return "Please Re-Enter Password";
                      } else if (value.length < 6) {
                        return "Password must be atleast 6 characters long";
                      } else if (value != _password.text) {
                        return "Password must be same as above";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _confirmPassword.text = value;
                    },
                  ),
                ],
              ),
            ),
            RoundedButton(
              color: Colors.blue[200],
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Newsreader'),
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
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

  Function(String) nameValidator = (String name) {
    if (name.isEmpty) {
      return "Name must not be empty ";
    }
    if (name.length < 3) return "Name must have more than 3 characters";
    if (name.contains("  ") || (name.contains(" ")))
      return "Name must not have empty spaces";
    return null;
  };

  Function(String) passValidator = (String pass) {
    if (pass.isEmpty && pass.length < 6) {
      return "Name must not be empty and less than 6 characters";
    }
    return null;
  };

  _navigator() async {
    if (_formKey.currentState.validate()) {
      try {
        await setCrdntialsForSignup(username.text, _password.text);
        Fluttertoast.showToast(
          msg: "You logged in!",
          gravity: ToastGravity.BOTTOM,
          fontSize: 25,
          textColor: Colors.white,
          backgroundColor: Colors.green[300],
          //timeInSecForIosWeb: 2,
        );
        await _setAccount();
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
    }
  }

  _setAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", username.text);
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            LoggedInHomeScreen(email: username.text),
      ),
    );
  }
}
