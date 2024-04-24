import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/component/my_tab_bar.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/categorymodel.dart';
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
  List<Category> categoriesList = [];
  List<String> lstImg = [
    '$urlHomePageImg' 'banner.png',
    '$urlHomePageImg' 'banner2.png',
    '$urlHomePageImg' 'banner3.png',
  ];
  bool isLoading = true;

  late CarouselController carouselController;
  int innerCurrentPage = 0;
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
    carouselController = CarouselController();
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
        .where((cate) => cate.des == expectedDescription)
        .toList();
  }

  List<Widget> getCategoryList(List<Category> categoriesList) {
    return GenderCategories.values.map((gender) {
      List<Category> categoryMenu = getCategoryFilter(gender, categoriesList);
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
                height: 270,
                width: double.infinity,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.primary,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                offset: const Offset(3, 4),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: CarouselSlider(
                            carouselController: carouselController,
                            items: lstImg.map((item) {
                              return Builder(builder: (BuildContext context) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              });
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  innerCurrentPage = index;
                                });
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 100,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withOpacity(0.2),
                            child: IconButton(
                              onPressed: () {
                                carouselController
                                    .animateToPage(innerCurrentPage - 1);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 100,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withOpacity(0.2),
                            child: IconButton(
                              onPressed: () {
                                carouselController
                                    .animateToPage(innerCurrentPage + 1);
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(lstImg.length, (index) {
                        bool isSelected = innerCurrentPage == index;
                        return GestureDetector(
                          onTap: () {
                            carouselController.animateToPage(index);
                          },
                          child: AnimatedContainer(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(200),
                            ),
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            curve: Curves.ease,
                            width: isSelected ? 40 : 30,
                            margin: EdgeInsets.symmetric(
                              horizontal: isSelected ? 6 : 3,
                            ),
                            height: 10,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              MyTabBar(tabController: _tabController),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 120,
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
                    const MyProductList(
                      startIndex: 0,
                      itemCount: 4,
                    ),
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
                    const MyProductList(
                      startIndex: 4,
                      itemCount: 4,
                    ),
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
