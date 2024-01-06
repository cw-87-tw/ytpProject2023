import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/util/login_textfield.dart';
import 'package:summarease/util/op_tile.dart';


class LoginPage extends StatefulWidget {

  void Function()? onTap;

  LoginPage({
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
    
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   }
    // );
    
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email_controller.text,
      password: password_controller.text,
    );

    // Navigator.pop(context);
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
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
                GestureDetector(
                    onTap: signUserIn,
                    child: OpTile(opName: '登入')
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
                          color: Theme.of(context).colorScheme.primary,
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
