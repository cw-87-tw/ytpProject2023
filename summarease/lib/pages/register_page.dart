import 'package:flutter/material.dart';
import 'package:summarease/util/login_textfield.dart';
import 'package:summarease/util/op_tile.dart';


class RegisterPage extends StatefulWidget {

  void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirmPw_controller = TextEditingController();

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
                const SizedBox(height: 20),
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
                  controller: confirmPw_controller,
                  hintText: '確認密碼',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                const OpTile(opName: '建立帳戶'),
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
