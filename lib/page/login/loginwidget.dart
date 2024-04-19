import 'package:flutter/material.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/component/my_textfield.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/mainpage.dart';

class LoginWidget extends StatefulWidget {
  final void Function()? onTap;
  const LoginWidget({super.key, this.onTap});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Mainpage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              SizedBox(
                width: 150,
                child: Image.asset(
                  '$urlImg' 'logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Đăng nhập".toUpperCase(),
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Theme.of(context).colorScheme.tertiary,
                      offset: const Offset(5, 4),
                      blurRadius: 25,
                    ),
                  ],
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //Email
              MyTextField(
                  controller: emailController,
                  hinText: "Tài khoản",
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              //Password
              MyTextField(
                  controller: passwordController,
                  hinText: "Mật khẩu",
                  obscureText: true),
              const SizedBox(
                height: 20,
              ),
              //Button
              MyButton(onTap: login, text: "Đăng nhập".toUpperCase()),
              const SizedBox(
                height: 10,
              ),
              //Register
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quên tài khoản",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Đăng ký",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
