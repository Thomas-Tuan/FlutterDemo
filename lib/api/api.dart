import 'dart:io';

import 'package:dio/dio.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/model/register_update_model.dart';
import 'package:myapp/data/model/user.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://huflit.id.vn:4321";

  API() {
    _dio.options.baseUrl = "$baseUrl/api";
  }

  Dio get sendRequest => _dio;
}

class APIRepository {
  API api = API();

  Map<String, dynamic> header(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
  }

  Future<String> update(UpdateProfile user, File? imageFile) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadToCloudinary(imageFile);
      }

      Map<String, dynamic> formDataMap = {
        "NumberID": user.numberID,
        "FullName": user.fullName,
        "PhoneNumber": user.phoneNumber,
        "BirthDay": user.birthDay,
        "Gender": user.gender,
        "SchoolYear": user.schoolYear,
        "SchoolKey": user.schoolKey,
        'ImageURL': imageUrl,
      };
      FormData formData = FormData.fromMap(formDataMap);

      User userSession = await getUser();
      Response res = await api.sendRequest.put('/Auth/updateProfile',
          options: Options(headers: header(userSession.token!)),
          data: formData);
      if (res.data["success"] != false) {
        return "ok";
      } else {
        return res.data["data"].toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<String> register(Signup user) async {
    try {
      final body = FormData.fromMap({
        "NumberID": user.numberID,
        "AccountID": user.accountID,
        "FullName": user.fullName,
        "PhoneNumber": user.phoneNumber,
        "ImageURL": user.imageUrl,
        "BirthDay": user.birthDay,
        "Gender": user.gender,
        "SchoolYear": user.schoolYear,
        "SchoolKey": user.schoolKey,
        "Password": user.password,
        "ConfirmPassword": user.confirmPassword
      });
      Response res = await api.sendRequest.post('/Student/signUp',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200 &&
          res.data["data"]
              .toString()
              .toLowerCase()
              .contains("Đăng ký thành công")) {
        return "ok";
      } else {
        return res.data["data"].toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<String> login(String accountID, String password) async {
    try {
      final body =
          FormData.fromMap({'AccountID': accountID, 'Password': password});
      Response res = await api.sendRequest.post('/Auth/login',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        final tokenData = res.data['data']['token'];
        // print("ok login");
        return tokenData;
      } else {
        return "login fail";
      }
    } catch (ex) {
      return "login fail";
      // rethrow;
    }
  }

  Future<String> changePassword(ChangePassword userPass) async {
    try {
      final body = FormData.fromMap({
        "OldPassword": userPass.password,
        "NewPassword": userPass.confirmPassword
      });
      Response res = await api.sendRequest.put('/Auth/ChangePassword',
          options: Options(headers: header(userPass.token!)), data: body);
      if (res.data["success"] != false) {
        return "ok";
      } else {
        return res.data.toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<User> current(String token) async {
    try {
      Response res = await api.sendRequest
          .get('/Auth/current', options: Options(headers: header(token)));
      return User.fromJson(res.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> forgotPassword(ChangePassword userPass) async {
    try {
      final body = FormData.fromMap({
        "accountID": userPass.accountID,
        "numberID": userPass.numberID,
        "newPass": userPass.confirmPassword
      });
      Response res = await api.sendRequest.put('/Auth/forgetPass', data: body);
      if (res.data["success"] != false) {
        return "ok";
      } else {
        return res.data.toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<List<Product>> fetchCategoriesById(int cateId) async {
    try {
      User userSession = await getUser();
      var user = await APIRepository().current(userSession.token!);
      Response res = await api.sendRequest.get('/Product/getListByCatId',
          options: Options(headers: header(userSession.token!)),
          queryParameters: {
            'AccountID': user.accountId,
            'categoryID': cateId,
          });
      if (res.data is List && res.data.isNotEmpty) {
        final List<dynamic> data = res.data;
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<List<Category>> fetchCategories() async {
    try {
      User userSession = await getUser();
      var user = await APIRepository().current(userSession.token!);
      Response res = await api.sendRequest.get('/Category/getList',
          options: Options(headers: header(userSession.token!)),
          queryParameters: {
            'AccountID': user.accountId,
          });
      if (res.data is List && res.data.isNotEmpty) {
        final List<dynamic> data = res.data;
        return data.map((item) => Category.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<String> addCategory(
      String cateName, String cateDes, File? cateImg) async {
    try {
      String? imageUrl;
      if (cateImg != null) {
        imageUrl = await uploadToCloudinary(cateImg);
      }
      User userSession = await getUser();
      var user = await APIRepository().current(userSession.token!);
      final body = FormData.fromMap({
        "Name": cateName,
        "Description": cateDes,
        "ImageURL": imageUrl,
        "AccountID": user.accountId
      });
      Response res = await api.sendRequest.post(
        '/addCategory',
        options: Options(headers: header(userSession.token!)),
        data: body,
      );
      if (res.data["success"] != false) {
        return "ok";
      } else {
        return res.data["data"].toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<String> editCategory(
      int id, String cateName, String cateDes, File? cateImg) async {
    try {
      String? imageUrl;
      if (cateImg != null) {
        imageUrl = await uploadToCloudinary(cateImg);
      }
      User userSession = await getUser();
      var user = await APIRepository().current(userSession.token!);
      final body = FormData.fromMap({
        "Id": id,
        "Name": cateName,
        "Description": cateDes,
        'ImageURL': imageUrl,
        "AccountID": user.accountId
      });
      Response res = await api.sendRequest.put(
        '/updateCategory',
        options: Options(headers: header(userSession.token!)),
        data: body,
      );
      if (res.data["success"] != false) {
        return "ok";
      } else {
        return res.data["data"].toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<String> delCategory(
    int id,
  ) async {
    try {
      User userSession = await getUser();
      var user = await APIRepository().current(userSession.token!);
      final body =
          FormData.fromMap({"categoryID": id, "AccountID": user.accountId});
      Response res = await api.sendRequest.delete(
        '/removeCategory',
        options: Options(headers: header(userSession.token!)),
        data: body,
      );
      if (res.data["success"] != false) {
        return "ok";
      } else {
        return res.data["data"].toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<List<Product>> fetchProduct() async {
    try {
      User userSession = await getUser();
      var user = await APIRepository().current(userSession.token!);
      Response res = await api.sendRequest.get('/Product/getList',
          options: Options(headers: header(userSession.token!)),
          queryParameters: {
            'AccountID': user.accountId,
          });
      if (res.data is List && res.data.isNotEmpty) {
        final List<dynamic> data = res.data;
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<String> addProduct(
    String proName,
    String proDes,
    File? proImg,
    double price,
    int cateId,
  ) async {
    try {
      String? imageUrl;
      if (proImg != null) {
        imageUrl = await uploadToCloudinary(proImg);
      }
      User userSession = await getUser();
      final body = FormData.fromMap({
        "Name": proName,
        "Description": proDes,
        "ImageURL": imageUrl,
        "Price": price,
        "CategoryID": cateId,
      });
      Response res = await api.sendRequest.post(
        '/addProduct',
        options: Options(headers: header(userSession.token!)),
        data: body,
      );
      if (res.data["success"] != false) {
        return "ok";
      } else {
        return res.data["data"].toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<String> editProduct(int id, String proName, String proDes,
      File? proImg, double price, int cateId, String srcImgPro) async {
    try {
      String? imageUrl;
      if (proImg != null) {
        imageUrl = await uploadToCloudinary(proImg);
      }
      User userSession = await getUser();
      var user = await APIRepository().current(userSession.token!);
      final body = FormData.fromMap({
        "Id": id,
        "Name": proName,
        "Description": proDes,
        'ImageURL': imageUrl ?? srcImgPro,
        'Price': price,
        'CategoryID': cateId,
        "AccountID": user.accountId
      });
      Response res = await api.sendRequest.put(
        '/updateProduct',
        options: Options(headers: header(userSession.token!)),
        data: body,
      );
      if (res.data["success"] != false) {
        return "ok";
      } else {
        return res.data["data"].toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<String> delProduct(
    int id,
  ) async {
    try {
      User userSession = await getUser();
      var user = await APIRepository().current(userSession.token!);
      final body =
          FormData.fromMap({"productID": id, "AccountID": user.accountId});
      Response res = await api.sendRequest.delete(
        '/removeProduct',
        options: Options(headers: header(userSession.token!)),
        data: body,
      );
      if (res.data["success"] != false) {
        return "ok";
      } else {
        return res.data["data"].toString();
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<String> addBill(List<Map<String, dynamic>> products) async {
    try {
      User userSession = await getUser();
      final body = products;
      Response res = await api.sendRequest.post(
        '/Order/addBill',
        options: Options(headers: header(userSession.token!)),
        data: body,
      );
      if (res.data.toString().contains('Thêm hóa đơn thành công')) {
        return "ok";
      } else {
        return 'failed';
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }

  Future<List<Product>> fetchBill() async {
    try {
      User userSession = await getUser();
      Response res = await api.sendRequest.get(
        '/Product/getListAdmin',
        options: Options(headers: header(userSession.token!)),
      );
      if (res.data is List && res.data.isNotEmpty) {
        final List<dynamic> data = res.data;
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (ex) {
      // ignore: avoid_print
      print('Error ' '$ex');
      rethrow;
    }
  }
}
