import 'package:flutter/material.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/component/my_tab_bar.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/data/provider/categoryprovider.dart';
import 'package:myapp/page/categories/categorybody.dart';
import 'package:myapp/page/product/product_home_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Category> lstCate;
  List<Category> categoriesList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: GenderCategories.values.length,
      vsync: this,
    );
    loadCateList();
  }

  Future<void> loadCateList() async {
    categoriesList = await ReadData().loadData();
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Category> getCategoryByGender(
      GenderCategories genderCategories, List<Category> categoriesList) {
    return categoriesList
        .where((cate) => cate.genderCategories == genderCategories)
        .toList();
  }

  List<Widget> getCategoryList(List<Category> categoriesList) {
    return GenderCategories.values.map((genderCategories) {
      List<Category> categoryMenu =
          getCategoryByGender(genderCategories, categoriesList);
      return ListView(
        scrollDirection: Axis.horizontal,
        children: categoryMenu.map((category) {
          return itemCateHomePage(category, context);
        }).toList(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  '$urlHomePageImg' 'banner.png',
                  fit: BoxFit.cover,
                ),
              ),
              MyTabBar(tabController: _tabController),
              SizedBox(
                height: 100,
                child: TabBarView(
                  controller: _tabController,
                  children: getCategoryList(categoriesList),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chương trình khuyến mãi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.asset(
                        '$urlHomePageImg' 'image-5.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Hàng mới về',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const MyProductList(),
                    Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    Text(
                      'Gợi ý cho bạn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const MyProductList(),
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
