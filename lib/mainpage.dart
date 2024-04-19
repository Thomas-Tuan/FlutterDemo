import 'package:flutter/material.dart';
import 'package:myapp/page/categories/categorywidget.dart';
import 'package:myapp/page/home/homepagewidget.dart';
import 'package:myapp/page/news/postwidget.dart';
import 'package:myapp/page/shops/shopinfowidget.dart';
import 'package:myapp/page/users/userinfowidget.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIdx = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    CategoryWidget(),
    NewsWidget(),
    ShopWidget(),
    MyAccountWidget(),
  ];

  void _onItemTapped(int idx) {
    setState(() {
      _selectedIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIdx),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Trang chủ",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: "Danh mục",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article_rounded),
              label: "Tin tức",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_business_rounded),
              label: "Cửa hàng",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: "Tài khoản",
            )
          ],
          currentIndex: _selectedIdx,
          selectedItemColor: Theme.of(context).colorScheme.tertiary,
          onTap: _onItemTapped),
    );
  }
}
