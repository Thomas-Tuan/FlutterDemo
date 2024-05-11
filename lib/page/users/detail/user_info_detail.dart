import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/auth/login_register.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/component/my_textfield.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/data/model/user.dart';

class AccountDetailWidget extends StatefulWidget {
  final User objUser;
  const AccountDetailWidget({Key? key, required this.objUser})
      : super(key: key);

  @override
  State<AccountDetailWidget> createState() => _AccountDetailWidgetState();
}

class _AccountDetailWidgetState extends State<AccountDetailWidget> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();

  final TextEditingController _birthdayController = TextEditingController();
  String? genderName;
  late File? _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _initializeFields() {
    _fullNameController.text = widget.objUser.fullName ?? 'Họ tên';
    _phoneNumberController.text = widget.objUser.phoneNumber ?? '';
    _numberIDController.text = widget.objUser.idNumber ?? '';
    _birthdayController.text = widget.objUser.birthDay ?? '';
    _imageFile =
        widget.objUser.imageURL != null ? File(widget.objUser.imageURL!) : null;
    genderName = widget.objUser.gender ?? "Nam";
  }

  Future<void> _selectImage() async {
    final selectedFile = await pickImageFromGallery();
    if (selectedFile != null) {
      setState(() {
        _imageFile = selectedFile;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin tài khoản",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Cập nhật".toUpperCase(),
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
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Image Upload
                    GestureDetector(
                      onTap: _selectImage,
                      child: Container(
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: _imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  _imageFile!.path,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Giới tính: ",
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text("Nam"),
                              leading: Transform.translate(
                                offset: const Offset(16, 0),
                                child: Radio(
                                  value: "Nam",
                                  groupValue: genderName,
                                  onChanged: (value) {
                                    setState(() {
                                      genderName = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text("Nữ"),
                              leading: Transform.translate(
                                offset: const Offset(16, 0),
                                child: Radio(
                                  value: "Nữ",
                                  groupValue: genderName,
                                  onChanged: (value) {
                                    setState(() {
                                      genderName = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: _birthdayController,
                      hinText: "Ngày sinh",
                      obscureText: false,
                      icon: Icons.calendar_month_sharp,
                      suffixIcon: Icons.calendar_today,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Button
                    MyButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          String response = await updateProfileForm(
                            _fullNameController,
                            _numberIDController,
                            _phoneNumberController,
                            genderName!,
                            _birthdayController.text,
                            _imageFile,
                            widget.objUser.token.toString(),
                          );

                          if (response == "ok") {
                            // ignore: use_build_context_synchronously
                            AlertDialogHelper.showAlertDialog(
                              context: context,
                              title: 'Cập nhật thành công',
                              content: 'Bạn sẽ được đưa về trang đăng nhập!',
                              buttonText: 'OK',
                              onButtonPressed: () {
                                logOut(context); // Log out logic
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginOrRegister(),
                                  ),
                                );
                              },
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
            ],
          ),
        ),
      ),
    );
  }
}
