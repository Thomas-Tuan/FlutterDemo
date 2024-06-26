import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/model/user.dart';
import 'package:myapp/page/qa_choose_size.dart';
import 'package:myapp/page/users/detail/user_info_bill.dart';
import 'package:myapp/page/users/detail/user_info_detail.dart';
import 'package:myapp/page/users/userinfobody.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountWidget extends StatefulWidget {
  const MyAccountWidget({super.key});

  @override
  State<MyAccountWidget> createState() => _MyAccountWidgetState();
}

class _MyAccountWidgetState extends State<MyAccountWidget> {
  User user = User.userEmpty();

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;
    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  Future<void> fetchBill() async {
    final fetchedBill = await APIRepository().fetchBill();
    setState(() {
      isLoading = false;
      lstProduct = fetchedBill;
    });
  }

  void _applySearchFilter() {
    final searchText = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = lstProduct.where((product) {
        bool matchesName = product.name!.toLowerCase().contains(searchText);
        return matchesName;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBill();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        nameController: searchController,
        onSearch: (_) => _applySearchFilter(),
      ),
      drawer: const MyDrawer(),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Xin chào',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${user.fullName}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountDetailWidget(
                              objUser: user,
                            ),
                          )),
                      child: Text(
                        'Cập nhật',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.tertiary,
                          decorationThickness: 1,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Đơn hàng',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          isLoading ? '' : lstProduct.length.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BillWidget()));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Lịch sử mua hàng',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.keyboard_arrow_right_outlined),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: itemMenuList(
                            '$urlUserPageImg' 'shopping-bag.png',
                            'Đang giao dịch',
                            context)),
                    Flexible(
                      child: itemMenuList('$urlUserPageImg' 'basket.png',
                          'Chờ lấy hàng', context),
                    ),
                    itemMenuList(
                      '$urlUserPageImg' 'in-transit.png',
                      'Đang giao ',
                      context,
                    ),
                    itemMenuList(
                      '$urlUserPageImg' 'shipped.png',
                      'Đã giao',
                      context,
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Image.asset(
                    '$urlUserPageImg' 'banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QASizeWidget()));
                    },
                    child: itemQAList('Hướng dẫn chọn size', context)),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách khách hàng thân thiết', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách bảo mật thông tin khách hàng', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách đổi/trả', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách giao vận chuyển online', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách thanh toán', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Giới thiệu', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Liên hệ', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Góp ý, phản hồi', context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
