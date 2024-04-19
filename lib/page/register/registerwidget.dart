import 'package:flutter/material.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/component/my_textfield.dart';
import 'package:myapp/conf/const.dart';

class RegisterWidget extends StatefulWidget {
  final void Function()? onTap;
  const RegisterWidget({super.key, this.onTap});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 70.0,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: Image.asset(
                      '$urlImg' 'logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //Name
                  MyTextField(
                      controller: nameController,
                      hinText: "Họ tên",
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  //Email
                  MyTextField(
                      controller: emailController,
                      hinText: "Email",
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  //Phone
                  MyTextField(
                      controller: phoneController,
                      hinText: "Số điện thoại",
                      obscureText: true),
                  const SizedBox(
                    height: 10,
                  ),
                  //Password
                  MyTextField(
                      controller: passwordController,
                      hinText: "Mật khẩu",
                      obscureText: true),
                  const SizedBox(
                    height: 10,
                  ),
                  //Confirm Password
                  MyTextField(
                      controller: confirmPasswordController,
                      hinText: "Xác nhận mật khẩu",
                      obscureText: true),
                  const SizedBox(
                    height: 20,
                  ),
                  //Button
                  MyButton(onTap: () {}, text: "Đăng ký".toUpperCase()),
                  const SizedBox(
                    height: 10,
                  ),
                  //Login
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Đã có tài khoản?",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                "Đăng nhập ngay!",
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            endIndent: 25,
                          )),
                          Text(
                            "Hoặc đăng ký bằng",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          Expanded(
                              child: Divider(
                            indent: 25,
                          )),
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 35),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        '$urlImg' 'google.png',
                                        height: 24,
                                        width: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Google',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 35),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        '$urlImg' 'fb.png',
                                        height: 24,
                                        width: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Facebook',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
