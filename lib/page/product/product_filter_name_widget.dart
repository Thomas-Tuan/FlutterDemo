import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:myapp/page/home/product_filter_body.dart';
import 'package:myapp/page/product/productbody.dart';
import 'package:provider/provider.dart';

class ProductFilterWithNameWidget extends StatefulWidget {
  final String searchText;

  const ProductFilterWithNameWidget({
    Key? key,
    required this.searchText,
  }) : super(key: key);
  @override
  State<ProductFilterWithNameWidget> createState() =>
      _ProductFilterWithNameWidgetState();
}

class _ProductFilterWithNameWidgetState
    extends State<ProductFilterWithNameWidget> {
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  Future<void> fetchProduct() async {
    try {
      final products = await APIRepository().fetchProduct();
      final filteredProducts = products.where((product) {
        return product.name!
            .toLowerCase()
            .contains(widget.searchText.toLowerCase());
      }).toList();

      setState(() {
        this.filteredProducts = filteredProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
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
  void initState() {
    super.initState();
    fetchProduct();
    searchController.addListener(_applySearchFilter);
  }

  void _openEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: MyAppBar(
        nameController: TextEditingController(text: widget.searchText),
        onSearch: (value) {},
      ),
      endDrawer: const FilterProductDrawer(),
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
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Danh sách sản phẩm',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Bộ lọc',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        ),
                                      ),
                                      Builder(builder: (context) {
                                        return IconButton(
                                          icon: Icon(
                                            Icons.filter_alt,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          ),
                                          onPressed: () =>
                                              _openEndDrawer(context),
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 700,
                                child: filteredProducts.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Không có sản phẩm phù hợp với bộ lọc !',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .inversePrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : GridView.builder(
                                        itemCount: filteredProducts.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 15,
                                          mainAxisSpacing: 20,
                                          crossAxisCount: 2,
                                        ),
                                        itemBuilder: (context, idx) {
                                          return itemProductGridView(
                                              filteredProducts[idx],
                                              context,
                                              cartProvider);
                                        }),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(
                                    context,
                                  );
                                },
                                child: Text(
                                  'Quay về danh mục'.toUpperCase(),
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    decorationThickness: 1,
                                    decorationStyle: TextDecorationStyle.solid,
                                  ),
                                ),
                              ),
                            ],
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
