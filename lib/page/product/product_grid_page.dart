import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/page/product/productbody.dart';

class MyProductGridList extends StatefulWidget {
  const MyProductGridList({super.key});

  @override
  State<MyProductGridList> createState() => _MyProductGridListState();
}

class _MyProductGridListState extends State<MyProductGridList> {
  List<Product> lstProduct = [];
  bool isLoading = true;
  Future<void> fetchProduct() async {
    try {
      final fetchProduct = await APIRepository().fetchProduct();
      setState(() {
        isLoading = false;
        lstProduct = fetchProduct;
      });
    } catch (e) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: GridView.builder(
          itemCount: lstProduct.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, idx) {
            return itemProductGridView(lstProduct[idx], context);
          }),
    );
  }
}
