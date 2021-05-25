import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mi_card/Screens/HomeScreen/loggedInHomeScreen.dart';
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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
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
                      password.text = value;
                    },
                  ),
                ],
              ),
            ),
            RoundedButton(
              color: Colors.blue[200],
              text: "LOGIN",
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Newsreader'),
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
                : Container(
                    width: 0,
                    height: 0,
                  ),
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
    if (pass.isEmpty) {
      return "Password must not be empty";
    }
    return null;
  };

  _navigator() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
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
      setState(() {
        isLoading = false;
      });
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
