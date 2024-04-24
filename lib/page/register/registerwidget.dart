import 'package:flutter/material.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/auth/login_register.dart';
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
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyTextField(
                          controller: _accountController,
                          hinText: "Tên tài khoản",
                          obscureText: false,
                          icon: Icons.account_box_outlined,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          controller: _fullNameController,
                          hinText: "Họ tên",
                          obscureText: false,
                          icon: Icons.person_2_outlined,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Number ID
                        MyTextField(
                            controller: _numberIDController,
                            hinText: "Number ID",
                            obscureText: false,
                            icon: Icons.numbers_rounded),
                        const SizedBox(
                          height: 10,
                        ),
                        //Phone
                        MyTextField(
                            controller: _phoneNumberController,
                            hinText: "Số điện thoại",
                            obscureText: false,
                            icon: Icons.phone_iphone),
                        const SizedBox(
                          height: 10,
                        ),
                        //Password
                        MyTextField(
                          controller: _passwordController,
                          hinText: "Mật khẩu",
                          obscureText: true,
                          icon: Icons.password_outlined,
                          suffixIcon: Icons.confirmation_num_sharp,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Confirm Password
                        MyTextField(
                          controller: _confirmPasswordController,
                          hinText: "Xác nhận mật khẩu",
                          obscureText: true,
                          icon: Icons.confirmation_num_sharp,
                          suffixIcon: Icons.confirmation_num_sharp,
                          passwordController: _passwordController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Button
                        MyButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              String response = await registerForm(
                                _accountController,
                                _fullNameController,
                                _phoneNumberController,
                                _numberIDController,
                                _passwordController,
                                _confirmPasswordController,
                              );
                              if (response == "ok") {
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(
                                      'Đăng ký thành công',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontSize: 16,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginOrRegister()));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content:
                                        Text('Đăng ký thất bại: $response'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          text: "Đăng ký".toUpperCase(),
                        ),
                      ],
                    ),
                  ),
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
