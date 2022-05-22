import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestHome extends StatelessWidget {
  TestHome({Key? key}) : super(key: key);

  var user = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(user.toString()),
      ),
    );
  }
}
