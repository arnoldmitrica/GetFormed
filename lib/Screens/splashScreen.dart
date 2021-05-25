import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mi_card/Screens/Welcome/welcome_screen.dart';
import 'package:mi_card/components/rounded_button.dart';
import 'package:mi_card/components/text_field_container.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/icons/description.svg"),
              width: size.width / 2,
              height: size.height / 4,
            ),
            RichText(
                text: TextSpan(
                    text: "MycreditloansApp.com",
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900]))),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 20, right: 20, bottom: 8),
              child: Container(
                alignment: Alignment.center,
                height: size.height / 4,
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Mycreditloans.com',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900])),
                  TextSpan(
                      text:
                          " faciliteza interactiunea dintre oameni si creditor, fara a mai fi nevoiti sa se intalneasca in persoana, dar care totodata ofera siguranta si transparenta unei interactiuni fizice intre cele doua parti.",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                ])),
              ),
            ),
            RoundedButton(
              color: Colors.indigo[700],
              text: "Take action",
              icon: Icon(Icons.arrow_forward_ios_outlined),
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Newsreader'),
              press: () => Navigator.of(context).pushAndRemoveUntil(
                // the new route
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    Fluttertoast.showToast(
                        msg: "Sign up or Log in before adding a form.");
                    return WelcomeScreen();
                  },
                ),
                // this function should return true when we're done removing routes
                // but because we want to remove all other screens, we make it
                // always return false
                (Route route) => false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
