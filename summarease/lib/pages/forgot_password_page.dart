import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/pages/login_page.dart';
import 'package:summarease/util/login_textfield.dart';
import 'package:summarease/util/op_tile.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final email_controller = TextEditingController();

  @override
  void dispose() {
    email_controller.dispose();
    super.dispose();
  }

  void showSentDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 197, 253, 200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 36,
                        ),
                        SizedBox(width: 16),
                        Text('已經傳連結囉!',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            fontSize: 20
                          )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              )
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage(onTap: () {},);
                    },
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                  ' Log in ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              )
            )
          ],
        );
      }
    );
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

  Future passwordReset() async {
    String userEmail = email_controller.text.trim();
    
    try {
      // It won't show error when the email isn't in the authentication.
      // It won't send email either.
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail);
      print("----------------------");
      print("---------- Hello $userEmail ----------");
      print("----------------------");
      // showSentDialog();
    } on FirebaseAuthException catch (e) {
      print("----------------------");
      print("---------- $e ----------");
      print("----------------------");
      // showError(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "請輸入你的 Email 信箱\n我們會寄給你更改密碼的連結!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                )
              ),
              SizedBox(height: 10),
              LoginTextfield(
                controller: email_controller,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 10),
              OpTile(
                opName: '更改密碼',
                color: Theme.of(context).colorScheme.primary,
                onTap: () {passwordReset();},
              ),
            ],
          ),
        )
      )
    );
  }
}