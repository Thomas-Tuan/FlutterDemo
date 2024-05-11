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

class ProductFilterWidget extends StatefulWidget {
  final List<String> priceFilters;
  const ProductFilterWidget({
    Key? key,
    required this.priceFilters,
  }) : super(key: key);

  @override
  State<ProductFilterWidget> createState() => _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends State<ProductFilterWidget> {
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  Future<void> fetchProduct() async {
    try {
      final products = await APIRepository().fetchProduct();
      final filteredProducts = products.where((product) {
        bool matchesPrice = widget.priceFilters.isEmpty ||
            widget.priceFilters.any((range) {
              final priceRange = getPriceRange(range);
              final minPrice = priceRange['min']!;
              final maxPrice = priceRange['max'];

              if (maxPrice == null) {
                // No upper limit
                return product.price! >= minPrice;
              } else {
                return product.price! >= minPrice && product.price! <= maxPrice;
              }
            });

        return matchesPrice;
      }).toList();

      setState(() {
        lstProduct = filteredProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Map<String, int> getPriceRange(String range) {
    switch (range) {
      case '100.000 - 200.000':
        return {'min': 100000, 'max': 200000};
      case '200.000 - 300.000':
        return {'min': 200000, 'max': 300000};
      case '300.000 - 500.000':
        return {'min': 300000, 'max': 500000};
      case '> 500.000':
        return {'min': 500000, 'max': 510000}; // No upper limit
      default:
        return {'min': 0, 'max': 0};
    }
  }

  void _applySearchFilter() {
    final searchText = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = lstProduct.where((product) {
        bool matchesName = product.name!
            .toLowerCase()
            .contains(searchText); // Check if name matches search
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
        nameController: searchController,
        onSearch: (_) => _applySearchFilter(),
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
                                child: lstProduct.isEmpty
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
                                        itemCount: lstProduct.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 15,
                                          mainAxisSpacing: 20,
                                          crossAxisCount: 2,
                                        ),
                                        itemBuilder: (context, idx) {
                                          return itemProductGridView(
                                              lstProduct[idx],
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
