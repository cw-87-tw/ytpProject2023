import 'package:flutter/material.dart';
import 'package:ui_tmp/util/op_tile.dart';

import 'home_nav.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
              SizedBox(height: 90),
              OpTile(opName: '登入'),
              OpTile(opName: '建立帳號'),
              SizedBox(height: 70),
              Text(
                '忘記密碼?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 30),
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
