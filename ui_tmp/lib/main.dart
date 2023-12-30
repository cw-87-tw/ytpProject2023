import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ui_tmp/pages/login_page.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('phoneDB');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.cyan.shade400,
          secondary: Colors.cyan.shade50,
          background: Colors.white,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          labelLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          bodySmall: TextStyle(
            color: Colors.black38,
            fontSize: 15,
          )
        )
      ),
      home: LoginPage(),
    );
  }
}
