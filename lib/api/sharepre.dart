// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/auth/login_register.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/model/register_update_model.dart';
import 'package:myapp/data/model/user.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveUser(User objUser) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String strUser = jsonEncode(objUser);
    prefs.setString('user', strUser);
    // print("Luu thanh cong: $strUser");
    return true;
  } catch (e) {
    // print(e);
    return false;
  }
}

Future<bool> logOut(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', '');
    // print("Logout thành công");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginOrRegister()),
        (route) => false);
    return true;
  } catch (e) {
    // print(e);
    return false;
  }
}

//
Future<User> getUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String strUser = pref.getString('user')!;
  return User.fromJson(jsonDecode(strUser));
}

Future<String> registerForm(
  TextEditingController accountID,
  TextEditingController fullname,
  TextEditingController phonenumber,
  TextEditingController numberID,
  TextEditingController password,
  TextEditingController confirmPassword,
) async {
  return await APIRepository().register(Signup(
    accountID: accountID.text,
    password: password.text,
    confirmPassword: confirmPassword.text,
    fullName: fullname.text,
    numberID: numberID.text,
    phoneNumber: phonenumber.text,
    gender: Common.getGender(1),
    birthDay: Common.formatCurrentDay(),
    schoolYear: 'test2',
    schoolKey: 'test1',
    imageUrl: '',
  ));
}

Future<File?> pickImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    return File(image.path);
  } else {
    return null;
  }
}

Future<String?> uploadToCloudinary(File imageFile) async {
  final dio = Dio();
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(imageFile.path),
    'upload_preset': uploadPreset,
  });

  const url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
  try {
    final response = await dio.post(url, data: formData);
    if (response.statusCode == 200) {
      final imageUrl = response.data['secure_url'];
      return imageUrl;
    } else {
      print('Cloudinary upload failed: ${response.statusMessage}');
      return null;
    }
  } catch (e) {
    print('Error uploading to Cloudinary: $e');
    return null;
  }
}

Future<String> updateProfileForm(
  TextEditingController fullname,
  TextEditingController numberID,
  TextEditingController phonenumber,
  String gender,
  String birthDay,
  File? imageFile,
  String token,
) async {
  return await APIRepository().update(
      UpdateProfile(
        fullName: fullname.text,
        numberID: numberID.text,
        phoneNumber: phonenumber.text,
        gender: gender,
        birthDay: birthDay.toString(),
        token: token,
        schoolKey: 'test1',
        schoolYear: 'test2',
      ),
      imageFile);
}

Future<String> forgotPasswordForm(
  String accountID,
  String numberID,
  String confirmPassword,
) async {
  return await APIRepository().forgotPassword(ChangePassword(
    accountID: accountID,
    confirmPassword: confirmPassword,
    numberID: numberID,
  ));
}

Future<String> changePasswordForm(
  String password,
  String confirmPassword,
  String token,
) async {
  return await APIRepository().changePassword(ChangePassword(
    password: password,
    confirmPassword: confirmPassword,
    token: token,
  ));
}

Future<String> handleCheckoutOneItem(Product? product) async {
  try {
    List<Map<String, dynamic>> productList = [];
    productList.add({
      "productID": product?.id,
      "count": 1,
    });
    String result = await APIRepository().addBill(productList);
    if (result == "ok") {
      return "ok";
    } else {
      return "failed";
    }
  } catch (e) {
    print('Error with $e');
    return 'failed';
  }
}

Future<String> handleCheckout(CartProvider cartProvider) async {
  try {
    List<Map<String, dynamic>> productList = [];
    productList = cartProvider.cart.cartItem.map((item) {
      return {
        "productID": item.productId,
        "count": item.quantity,
      };
    }).toList();
    String result = await APIRepository().addBill(productList);
    if (result == "ok") {
      return "ok";
    } else {
      return "failed";
    }
  } catch (e) {
    print('Error with $e');
    return 'failed';
  }
}
