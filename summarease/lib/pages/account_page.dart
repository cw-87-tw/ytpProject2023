import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/util/op_tile.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void changePw() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: 80,
          leading: const Icon(Icons.person, color: Colors.white, size: 35),
          title: Text(
            '個人帳號',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                  Icons.account_circle,
                  size: 200,
                  color: Colors.grey.shade300),
              Text(
                user.email!,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    OpTile(
                      opName: '更改密碼',
                      color: Theme.of(context).colorScheme.secondary,
                      onTap: changePw,
                    ),
                    OpTile(
                      opName: '登出',
                      color: Theme.of(context).colorScheme.secondary,
                      onTap: signUserOut,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        )
    );
  }
}

