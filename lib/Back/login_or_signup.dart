import 'package:flutter/material.dart';
import 'package:project_algora_2/Screens/login_screen.dart';
import 'package:project_algora_2/Screens/signup_screen.dart';

class LoginOrSignup extends StatefulWidget{

  State<LoginOrSignup> createState(){
    return _LoginOrSignupState();
  }
}
class _LoginOrSignupState extends State<LoginOrSignup>{

  bool showLoginScreen = true;

  void toogleScreens(){
    setState(() {
      showLoginScreen = !showLoginScreen;
    }
    );
  }
  Widget build(BuildContext context){
    if(showLoginScreen) {
      return LoginScreen(
        toogleScreens,
      );

    }
      else {
      return SignupScreen(
        toogleScreens,
      );
    }
    }
    }
