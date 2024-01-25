import 'package:flutter/material.dart';
import 'package:summarease/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            primary: Colors.cyan.shade200,
            secondary: Colors.cyan.shade100,
            background: Colors.white,
            surface: Colors.cyan.shade50,
            outline: Colors.cyan.shade300,
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
      home: AuthPage(),
    );
  }
}
