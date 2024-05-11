import 'package:flutter/material.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/page/product/product_grid_page.dart';

class ProductWidget extends StatefulWidget {
  final Category objCat;
  const ProductWidget({Key? key, required this.objCat}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isLoading = true;
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
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
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: MyProductGridList(
                      objCat: widget.objCat,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
