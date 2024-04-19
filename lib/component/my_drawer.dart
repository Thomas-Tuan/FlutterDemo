import 'package:flutter/material.dart';
import 'package:myapp/component/my_drawer_tile.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/mainpage.dart';
import 'package:myapp/page/login/loginwidget.dart';
import 'package:myapp/page/register/registerwidget.dart';
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
            text: "Đăng ký",
            icon: Icons.gamepad_sharp,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterWidget())),
          ),
          MyDrawerTile(
            text: "Đăng nhập",
            icon: Icons.signpost_outlined,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginWidget())),
          ),
          const Spacer(),
          MyDrawerTile(
            text: "Đăng xuất",
            icon: Icons.logout,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterWidget())),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
