import 'package:shared_preferences/shared_preferences.dart';

Future<String> getCrdntialsForSignup(String username) async {
  final sharedPreferences = await SharedPreferences.getInstance();

  if (sharedPreferences.getString(username) == null) {
    return Future.delayed(
        Duration(seconds: 2), () => 'Account created. You logged in.');
  } else {
    return Future.delayed(Duration(seconds: 2),
        () => throw 'There is another account with this e-mail');
  }
}

Future<String> getCrdntialsForLogin(String username) async {
  final sharedPreferences = await SharedPreferences.getInstance();

  if (sharedPreferences.getString(username) != null) {
    return Future.delayed(Duration(seconds: 2), () => 'You are logged in now');
  } else {
    return Future.delayed(Duration(seconds: 2),
        () => throw 'No account associated with the e-mail');
  }
}
