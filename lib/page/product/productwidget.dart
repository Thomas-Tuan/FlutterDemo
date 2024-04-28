import 'package:flutter/material.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/page/product/product_grid_page.dart';

class ProductWidget extends StatefulWidget {
  final Category objCat;
  const ProductWidget({Key? key, required this.objCat}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
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
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Center(
                    child: Text(
                      'Quay về danh mục'.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.tertiary,
                        decorationThickness: 1,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
