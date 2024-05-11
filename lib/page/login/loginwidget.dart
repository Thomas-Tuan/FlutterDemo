import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/component/my_textfield.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/mainpage.dart';
import 'package:myapp/page/forgot_password.dart';

class LoginWidget extends StatefulWidget {
  final void Function()? onTap;
  const LoginWidget({super.key, this.onTap});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  login() async {
    //lấy token (lưu share_preference)
    String token = '';
    try {
      token = await APIRepository()
          .login(accountController.text, passwordController.text);
      // ignore: unnecessary_null_comparison
      if (!token.contains('login fail')) {
        var user = await APIRepository().current(token);
        user.token = token;
        // save share
        saveUser(user);
        //
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Mainpage()));
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Đăng nhập thất bại !'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error ' '$e');
    }
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
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //Email
              MyTextField(
                  controller: accountController,
                  hinText: "Tài khoản",
                  obscureText: false,
                  icon: Icons.account_box_outlined),
              const SizedBox(
                height: 10,
              ),
              //Password
              MyTextField(
                controller: passwordController,
                hinText: "Mật khẩu",
                obscureText: true,
                icon: Icons.password_outlined,
                suffixIcon: Icons.confirmation_num_sharp,
              ),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPassWidget()));
                          },
                          child: Text(
                            "Quên tài khoản",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
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
