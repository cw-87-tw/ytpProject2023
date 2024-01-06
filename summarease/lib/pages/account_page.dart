import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/pages/login_or_register_page.dart';
import 'package:summarease/util/op_tile.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
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
                'username',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    OpTile(opName: '更改密碼'),
                    GestureDetector(
                      onTap: signUserOut,
                      child: OpTile(opName: '登出')
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
                ),
                child: Text(
                  '邪惡傳送門2!',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}

