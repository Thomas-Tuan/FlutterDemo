import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/productmodel.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List<String> lstImg = [
    '$urlNewsPageImg' 'banner4.jpg',
    '$urlNewsPageImg' 'banner2.jpg',
    '$urlNewsPageImg' 'banner3.jpg',
  ];
  int innerCurrentPage = 0;
  late CarouselController carouselController;
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    carouselController = CarouselController();
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
    var myTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    return Scaffold(
      appBar: MyAppBar(
        nameController: searchController,
        onSearch: (_) => _applySearchFilter(),
      ),
      drawer: const MyDrawer(),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Column(
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
                                    fit: BoxFit.cover,
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
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "TIN MỚI NHẤT",
                      style: myTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          offset: const Offset(0, 4),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        '$urlNewsPageImg' 'image-17.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "GỢI Ý TOP 10 MẪU ÁO NAM ĐỘC ĐÁO, HÓT HÒN HỌT",
                      style: myTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              offset: const Offset(0, 4),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          '$urlNewsPageImg' 'image-18.png',
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              offset: const Offset(0, 4),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          '$urlNewsPageImg' 'image-19.png',
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
