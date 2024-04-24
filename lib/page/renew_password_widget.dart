import 'package:flutter/material.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/auth/login_register.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/component/my_textfield.dart';
import 'package:myapp/data/model/user.dart';

class RenewPassWidget extends StatefulWidget {
  final User objUser;
  const RenewPassWidget({Key? key, required this.objUser}) : super(key: key);

  @override
  State<RenewPassWidget> createState() => _RenewPassWidgetState();
}

class _RenewPassWidgetState extends State<RenewPassWidget> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật mật khẩu"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GradientBackground(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextField(
                  controller: _passwordController,
                  hinText: "Mật khẩu cũ",
                  obscureText: true,
                  icon: Icons.password_outlined,
                  suffixIcon: Icons.confirmation_num_sharp,
                  passwordController: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: _confirmPasswordController,
                  hinText: "Nhập lại mật khẩu mới",
                  obscureText: true,
                  icon: Icons.confirmation_num_sharp,
                  suffixIcon: Icons.confirmation_num_sharp,
                  passwordController: _passwordController,
                ),
                const SizedBox(
                  height: 50,
                ),
                MyButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      String response = await changePasswordForm(
                        _passwordController.text,
                        _confirmPasswordController.text,
                        widget.objUser.token.toString(),
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginOrRegister()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
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
                            content: Text('Cập nhật thất bại: $response'),
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
        ),
      ),
    );
  }
}
