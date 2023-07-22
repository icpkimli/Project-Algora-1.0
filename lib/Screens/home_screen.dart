import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Center(
                child: Text('HomeScreen'),
            ),
            Text(user.email!),
            IconButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            }, icon: Icon(Icons.logout_outlined))
          ],
        ),
      ),
    );
  }
}
