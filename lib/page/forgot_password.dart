import 'package:flutter/material.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/auth/login_register.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/component/my_textfield.dart';
import 'package:myapp/conf/const.dart';

class ForgotPassWidget extends StatefulWidget {
  const ForgotPassWidget({Key? key}) : super(key: key);

  @override
  State<ForgotPassWidget> createState() => _ForgotPassWidgetState();
}

class _ForgotPassWidgetState extends State<ForgotPassWidget> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quên mật khẩu",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
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
                    height: 25,
                  ),
                  Text(
                    "Quên tài khoản".toUpperCase(),
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        MyTextField(
                          controller: _accountController,
                          hinText: "Tên tài khoản",
                          obscureText: false,
                          icon: Icons.account_box_outlined,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                            controller: _numberIDController,
                            hinText: "Number ID",
                            obscureText: false,
                            icon: Icons.numbers_rounded),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          controller: _confirmPasswordController,
                          hinText: "Nhập lại mật khẩu mới",
                          obscureText: true,
                          icon: Icons.confirmation_num_sharp,
                          suffixIcon: Icons.confirmation_num_sharp,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        MyButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              String response = await forgotPasswordForm(
                                _accountController.text,
                                _numberIDController.text,
                                _confirmPasswordController.text,
                              );

                              if (response == "ok") {
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Cập nhật thành công',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      'Bạn sẽ được đưa về trang đăng nhập !',
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
                                          logOut(context);
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
                                        Text('Cập nhật thất bại: $response'),
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
                          text: "Cập nhật".toUpperCase(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
