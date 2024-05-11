import 'package:flutter/material.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/provider/favoriteproductprovider.dart';
import 'package:myapp/page/product/detail/product_detail_bottom.dart';
import 'package:myapp/page/product/detail/product_detail_choose_color.dart';
import 'package:myapp/page/product/detail/product_detail_choose_size.dart';
import 'package:myapp/page/product/detail/product_detail_slider.dart';
import 'package:provider/provider.dart';

class ProductDetailWidget extends StatefulWidget {
  final Product objPro;
  const ProductDetailWidget({Key? key, required this.objPro}) : super(key: key);

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  String? selectedSize;
  void selectSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProductProvider>(
        context); // Access the favorite provider
    final isFavorite = favoriteProvider.isFavorite(widget.objPro);

    var myPrimaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    var mySecondaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontSize: 18,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết sản phẩm"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              favoriteProvider.toggleFavorite(widget.objPro);
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.secondary,
              size: 30, // Adjust icon size as needed
            ),
          ),
        ],
      ),
      body: GradientBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductDetailCarouselSlider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.objPro.name!, style: myPrimaryTextStyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('SMN6036-VAG', style: mySecondaryTextStyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      Common.formatMoneyCurrency(
                          widget.objPro.price.toString()),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.tertiary,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const ColorSelect(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Kích cỡ:', style: mySecondaryTextStyle),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Vui lòng chọn kích thước sản phẩm',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizeCheckBox(
                          size: 'L',
                          selectedSize: selectedSize,
                          onSelect: selectSize,
                        ),
                      ),
                      Expanded(
                        child: SizeCheckBox(
                          size: 'XL',
                          selectedSize: selectedSize,
                          onSelect: selectSize,
                        ),
                      ),
                      Expanded(
                        child: SizeCheckBox(
                          size: 'XXL',
                          selectedSize: selectedSize,
                          onSelect: selectSize,
                        ),
                      ),
                      Expanded(
                        child: SizeCheckBox(
                          size: '3XL',
                          selectedSize: selectedSize,
                          onSelect: selectSize,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const Spacer(),
            BottomProductDetail(
              mySecondaryTextStyle: mySecondaryTextStyle,
              objPro: widget.objPro,
            ),
          ],
        ),
      ),
    );
  }
}
