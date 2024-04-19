import 'package:flutter/material.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/provider/productprovider.dart';
import 'package:myapp/page/product/productbody.dart';

class MyProductGridList extends StatefulWidget {
  const MyProductGridList({super.key});

  @override
  State<MyProductGridList> createState() => _MyProductGridListState();
}

class _MyProductGridListState extends State<MyProductGridList> {
  List<Product> lstProduct = [];
  Future<String> loadProductList() async {
    lstProduct = await ReadData().loadData();
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadProductList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadProductList(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
      },
    );
  }
}
