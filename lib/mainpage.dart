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
        child: _widgetOptions[_selectedIdx],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () => _onItemTapped(0),
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(
                width: 3, color: Theme.of(context).colorScheme.secondary),
          ),
          child: Icon(
            Icons.home,
            size: 32,
            color: _selectedIdx == 0
                ? Theme.of(context).colorScheme.tertiary
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.category_rounded,
                    size: 32,
                    color: _selectedIdx == 1
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => _onItemTapped(1),
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.article_rounded,
                    size: 32,
                    color: _selectedIdx == 2
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => _onItemTapped(2),
                ),
              ),
              const SizedBox(
                width: 60,
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.add_business_rounded,
                    size: 32,
                    color: _selectedIdx == 3
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => _onItemTapped(3),
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.account_circle_rounded,
                    size: 32,
                    color: _selectedIdx == 4
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => _onItemTapped(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
