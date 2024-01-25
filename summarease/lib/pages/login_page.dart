import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/util/login_textfield.dart';
import 'package:summarease/util/op_tile.dart';

class LoginPage extends StatefulWidget {

  final Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  void signUserIn() async {
    //loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
    //sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email_controller.text,
        password: password_controller.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber, color: Colors.red.shade300,),
                      Text(
                        ' Error: ' + msg,
                        style: TextStyle(color: Colors.red.shade300, fontSize: 20)
                      ),
                    ],
                  )
              ),
            ),
          );
        }
    );
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
                  height: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset('assets/summarease_logo.png', fit: BoxFit.cover,)
                ),
                SizedBox(height: 20),
                Text(
                  'SUMMAREASE',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'Summarize with ease.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 50),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '忘記密碼?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                OpTile(
                  opName: '登入',
                  color: Theme.of(context).colorScheme.primary,
                  onTap: signUserIn,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '不是用戶?  ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        '建立帳戶',
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
