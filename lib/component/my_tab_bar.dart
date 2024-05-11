import 'package:flutter/material.dart';
import 'package:myapp/data/model/categorymodel.dart';

class MyTabBar extends StatelessWidget {
  final TabController? tabController;
  const MyTabBar({Key? key, this.tabController}) : super(key: key);

  List<Tab> _buildGenderTab() {
    return GenderCategories.values.map((gender) {
      String tabText;
      switch (gender) {
        case GenderCategories.males:
          tabText = "Nam";
          break;
        case GenderCategories.females:
          tabText = "Nữ";
          break;
        case GenderCategories.kids:
          tabText = "Trẻ em";
          break;
      }
      return Tab(
        text: tabText,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TabBar(
        controller: tabController,
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        tabs: _buildGenderTab(),
      ),
    );
  }
}
