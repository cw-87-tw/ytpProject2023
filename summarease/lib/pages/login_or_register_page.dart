import 'package:flutter/material.dart';
import 'package:summarease/pages/login_page.dart';
import 'package:summarease/pages/register_page.dart';
import 'package:summarease/util/login_textfield.dart';
import 'package:summarease/util/op_tile.dart';

import 'home_nav.dart';



class LoginOrRegisterPage extends StatelessWidget {

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  LoginOrRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.all_inclusive,
                size: 200,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                child: OpTile(opName: '登入帳戶')
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                ),
                child: OpTile(opName: '建立帳戶')
              ),
              SizedBox(height: 70),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                ),
                child: Text(
                  '邪惡傳送門!',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
