import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/util/login_textfield.dart';
import 'package:summarease/util/op_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirmPassword_controller = TextEditingController();

  void signUserUp() async {
    //sign in
    try {
      if (password_controller.text == confirmPassword_controller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email_controller.text.trim(),
          password: password_controller.text.trim(),
        );

        User? user = FirebaseAuth.instance.currentUser;
        Map<String, dynamic> userRegisterData = {
          'email': email_controller.text.trim(),
          'password': password_controller.text.trim(),
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set(userRegisterData)
            .then((value) {
              print("---------- added users document ----------");
            })
            .catchError((error) {
              print("---------- failed adding users document ----------");
            });
      } else {
        showError('passwords don\'t match');
      }
    } on FirebaseAuthException catch (e) {
      showError(e.code);
    }
  }

  void showError(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: BorderSide(width: 2, color: Colors.red.shade300)
            ),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.warning_amber,
                      color: Colors.red.shade300,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Error: $msg",
                        style: TextStyle(color: Colors.red.shade300, fontSize: 20),
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              )
            ),
          );
        });
  }

  @override
  void dispose() {
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/summarease_logo.png',
                      fit: BoxFit.cover,
                    )),
                SizedBox(height: 17),
                Text(
                  'SUMMAREASE',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Summarize with ease.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 40),
                LoginTextfield(
                  controller: email_controller,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                LoginTextfield(
                  controller: password_controller,
                  hintText: '密碼',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                LoginTextfield(
                  controller: confirmPassword_controller,
                  hintText: '確認密碼',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                OpTile(
                  opName: '建立',
                  color: Theme.of(context).colorScheme.primary,
                  onTap: signUserUp,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '已有帳戶?  ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        '登入帳戶',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
