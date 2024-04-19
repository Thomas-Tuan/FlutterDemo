import 'package:flutter/material.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/provider/productprovider.dart';
import 'package:myapp/page/product/product_detail_widget.dart';
import 'package:myapp/page/product/productbody.dart';

class MyProductList extends StatefulWidget {
  const MyProductList({super.key});

  @override
  State<MyProductList> createState() => _MyProductListState();
}

class _MyProductListState extends State<MyProductList> {
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
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductDetailWidget())),
          child: SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: lstProduct
                  .take(4)
                  .map((pro) => itemProductView(pro, context))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
