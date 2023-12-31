import 'package:flutter/material.dart';
import 'package:summarease/util/login_textfield.dart';
import 'package:summarease/util/op_tile.dart';

import 'home_nav.dart';



class RegisterPage extends StatelessWidget {

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirmPw_controller = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.all_inclusive,
                  size: 150,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 20),
                LoginTextfield(
                  controller: email_controller,
                  hintText: 'Email',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                LoginTextfield(
                  controller: password_controller,
                    hintText: '密碼',
                    obscureText: true,
                ),
                SizedBox(height: 10),
                LoginTextfield(
                  controller: confirmPw_controller,
                  hintText: '確認密碼',
                  obscureText: true,
                ),
                SizedBox(height: 30),
                OpTile(opName: '建立'),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
