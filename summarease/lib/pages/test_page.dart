import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TestPage extends StatelessWidget {
  TestPage({super.key});
  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: 80,
          leading: const Icon(Icons.person, color: Colors.white, size: 35),
          title: Text(
            '測試區',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            ],
          ),
        )
    );
  }
}

