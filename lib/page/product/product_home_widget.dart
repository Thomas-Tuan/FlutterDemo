import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/page/product/productbody.dart';

class MyProductList extends StatefulWidget {
  const MyProductList({super.key, this.startIndex = 0, this.itemCount = 4});
  final int startIndex;
  final int itemCount;
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
    final endIndex = (widget.startIndex + widget.itemCount) < lstProduct.length
        ? widget.startIndex + widget.itemCount
        : lstProduct.length;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: lstProduct
                  .sublist(widget.startIndex, endIndex)
                  .map((pro) => itemProductView(pro, context))
                  .toList(),
            ),
          );
  }
}
