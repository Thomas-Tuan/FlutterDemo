import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:myapp/page/product/productbody.dart';
import 'package:provider/provider.dart';

class MyProductGridList extends StatefulWidget {
  final Category objCat;
  const MyProductGridList({Key? key, required this.objCat}) : super(key: key);

  @override
  State<MyProductGridList> createState() => _MyProductGridListState();
}

class _MyProductGridListState extends State<MyProductGridList> {
  List<Product> lstProduct = [];
  bool isLoading = true;

  Future<void> fetchProductByCate() async {
    try {
      final fetchProductByCate =
          await APIRepository().fetchCategoriesById(widget.objCat.id!);
      setState(() {
        isLoading = false;
        lstProduct = fetchProductByCate;
      });
    } catch (e) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProductByCate();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return lstProduct.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Danh sách sản phẩm này chưa được thêm vào  !',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            height: 700,
            child: GridView.builder(
                itemCount: lstProduct.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, idx) {
                  return itemProductGridView(
                      lstProduct[idx], context, cartProvider);
                }),
          );
  }
}
