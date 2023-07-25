import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/custom/my_button.dart';
import 'package:project_algora_2/custom/my_text.dart';
import 'package:project_algora_2/custom/my_text_field.dart';

import '../Back/auth_service.dart';

class SignupScreen extends StatefulWidget {
  final Function()? onTap;
  const SignupScreen(this.onTap, {super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool? isChecked = true;

  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else
        print("Password doesn't match");
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Center(
              child: Text('wrong'),
            ),
          );
        });
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    UserCredential? userCredential = await AuthService.signInWithGoogle();
    if (userCredential != null) {
      // The user is signed in successfully
      print("Signed in with Google: ${userCredential.user?.displayName}");

      // Navigate to the HomeScreen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Sign-in was not successful or was cancelled
      print("Sign-in with Google was not successful.");

      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign-in with Google failed. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _handleFacebookSignIn(BuildContext context) async {
    UserCredential? userCredential = await AuthService.signInWithFacebook();
    if (userCredential != null) {
      // The user is signed in successfully with Facebook
      print("Signed in with Facebook: ${userCredential.user?.displayName}");

      // Navigate to the HomeScreen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Sign-in with Facebook was not successful or was cancelled
      print("Sign-in with Facebook was not successful.");

      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign-in with Facebook failed. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset:
            false, //this use for prevent the content from resizing
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 75, bottom: 25),
                child: MyText("Let's Create An Account", 24),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: MyTextField(emailController, 'example@gmail.com', false),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: MyTextField(
                    passwordController, 'new password', isChecked ?? false),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: MyTextField(confirmPasswordController,
                    'confirm new password', isChecked ?? false),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: Colors.blue,
                    tristate: false,
                    onChanged: (newBool) {
                      setState(() {
                        isChecked = newBool;
                      });
                    },
                  ),
                  Text('Show password'),
                ],
              ),
              SizedBox(
                height: 65,
                width: 360,
                child: MyButton(signUserIn, 'Sign up'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        color: Colors.black54,
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: MyText('Or continue with', 12),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black54,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      onPressed: () => _handleGoogleSignIn(context),
                      icon: Image.asset(
                        'assets/images/google.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      onPressed: () => _handleFacebookSignIn(context),
                      icon: Image.asset(
                        'assets/images/facebook.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
