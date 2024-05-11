import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/component/my_tab_bar.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/page/categories/category_grid_page.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;
  List<Category> categoriesList = [];
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  Future<void> fetchAllCategories() async {
    try {
      final fetchedCategories = await APIRepository().fetchCategories();
      setState(() {
        isLoading = false;
        categoriesList = fetchedCategories;
      });
    } catch (e) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: GenderCategories.values.length,
      vsync: this,
    );
    fetchAllCategories();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Category> getCategoryFilter(
      GenderCategories gender, List<Category> categoriesList) {
    final expectedDescription = gender.displayName;
    return categoriesList
        .where((cate) =>
            cate.des.toString().toLowerCase().contains(expectedDescription))
        .toList();
  }

  List<Widget> getCategoryList(List<Category> categoriesList) {
    return GenderCategories.values.map((gender) {
      List<Category> categoryFilter = getCategoryFilter(gender, categoriesList);
      return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: MyCategoryGridList(categoryFilter: categoryFilter));
    }).toList();
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
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTabBar(tabController: _tabController),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 850,
                        child: TabBarView(
                          controller: _tabController,
                          children: getCategoryList(categoriesList),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
