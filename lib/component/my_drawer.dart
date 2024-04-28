import 'package:flutter/material.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/auth/login_register.dart';
import 'package:myapp/component/my_drawer_tile.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/mainpage.dart';
import 'package:myapp/page/categories/crud_category.dart';
import 'package:myapp/page/product/crud_product.dart';
import 'package:myapp/page/product/favorite/favorite_list_widget.dart';
import 'package:myapp/page/settingwidget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: SizedBox(
              child: Image.asset(
                '$urlImg' 'logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          MyDrawerTile(
            text: "Trang chủ",
            icon: Icons.home,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Mainpage())),
          ),
          Divider(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          MyDrawerTile(
            text: "Cài đặt",
            icon: Icons.settings,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingWidget())),
          ),
          Divider(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          MyDrawerTile(
            text: "Yêu thích",
            icon: Icons.list,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FavoriteWidget())),
          ),
          Divider(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          MyDrawerTile(
            text: "Danh mục",
            icon: Icons.category_sharp,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CRUDCate())),
          ),
          Divider(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          MyDrawerTile(
            text: "Sản phẩm",
            icon: Icons.pages_sharp,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CRUDProduct())),
          ),
          Divider(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          const Spacer(),
          MyDrawerTile(
              text: "Đăng xuất",
              icon: Icons.logout,
              onTap: () {
                logOut(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginOrRegister(),
                    ));
              }),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
