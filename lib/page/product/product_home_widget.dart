import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/page/product/productbody.dart';

class MyProductList extends StatefulWidget {
  final String sortList;
  const MyProductList({super.key, required this.sortList});

  @override
  State<MyProductList> createState() => _MyProductListState();
}

class _MyProductListState extends State<MyProductList> {
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
      print('error $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: 200,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.sortList.toString().contains('Asc')
                    ? lstProduct
                        .take(4)
                        .map((pro) => itemProductView(pro, context))
                        .toList()
                    : lstProduct
                        .take(4)
                        .toList()
                        .reversed
                        .map((pro) => itemProductView(pro, context))
                        .toList()),
          );
  }
}
