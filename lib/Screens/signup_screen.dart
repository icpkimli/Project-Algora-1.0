import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/custom/my_button.dart';
import 'package:project_algora_2/custom/my_text.dart';
import 'package:project_algora_2/custom/my_text_field.dart';

class SignupScreen extends StatefulWidget {
  final Function()? onTap;
  const SignupScreen(this.onTap,{super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
    try{
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text);
      }
      else
        print("Password doesn't match");
      Navigator.pop(context);
    }on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }
  
  void showErrorMessage(String message){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Center(
          child: Text('wrong'),
        ),
      );
    });
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 75, bottom: 25),
                  child: MyText("Let's Create An Account", 24),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: MyTextField(emailController, 'Jexample@gmail.com', false),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child:
                      MyTextField(passwordController, 'new password', false),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: MyTextField(confirmPasswordController, 'confirm new password', true),
                ),
                SizedBox(
                    height: 60,
                    width: 360,
                    child: MyButton(
                        signUserIn,
                        'Sign up'
                    ),
                  ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Colors.black54,
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200],
                      ),
                      child: Image.asset(
                        'assets/images/google.png',
                        height: 60,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[200],
                        ),
                        child: Image.asset(
                          'assets/images/facebook.png',
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Log in now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


