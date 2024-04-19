import 'package:flutter/material.dart';
import 'package:myapp/page/login/loginwidget.dart';
import 'package:myapp/page/register/registerwidget.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginWidget(
        onTap: togglePage,
      );
    } else {
      return RegisterWidget(
        onTap: togglePage,
      );
    }
  }
}
