import 'package:flutter/material.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/page/shops/my_description_shop.dart';
import 'package:myapp/page/shops/my_location.dart';
import 'package:myapp/page/shops/shopinfobody.dart';

class ShopWidget extends StatefulWidget {
  const ShopWidget({super.key});

  @override
  State<ShopWidget> createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> {
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
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
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  '$urlShopPageImg' 'banner-6.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const MyInfoShop(),
              Divider(
                indent: 40,
                endIndent: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(
                height: 10,
              ),
              const MyLocation(),
              Divider(
                indent: 40,
                endIndent: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(
                height: 10,
              ),
              const MyShopDes(),
            ],
          ),
        ),
      ),
    );
  }
}
