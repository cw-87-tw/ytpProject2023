import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/pages/login_or_register_page.dart';

import 'home_nav.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is already logged in
          if (snapshot.hasData) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => LoginOrRegisterPage())
            // );
            return Home();
          }
          //user is not logged in
          else{
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
