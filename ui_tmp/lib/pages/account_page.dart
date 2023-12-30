import 'package:flutter/material.dart';
import 'package:ui_tmp/util/account_info_tile.dart';
import 'package:ui_tmp/util/op_tile.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
        leading: const Icon(Icons.person, color: Colors.white, size: 35),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '個人帳號',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey.shade300),
            const AccountInfoTile(username: 'yayyyyy', something: 'blahblahblah'),
            const SizedBox(
              width: 300,
              child: Column(
                children: [
                  OpTile(opName: '更改密碼'),
                  OpTile(opName: '登出'),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

