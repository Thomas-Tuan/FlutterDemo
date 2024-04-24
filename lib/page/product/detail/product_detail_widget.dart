import 'package:flutter/material.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/page/product/detail/product_detail_bottom.dart';
import 'package:myapp/page/product/detail/product_detail_choose_color.dart';
import 'package:myapp/page/product/detail/product_detail_choose_size.dart';
import 'package:myapp/page/product/detail/product_detail_slider.dart';

class ProductDetailWidget extends StatefulWidget {
  final Product objPro;
  const ProductDetailWidget({Key? key, required this.objPro}) : super(key: key);

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: Icon(
              Icons.h_mobiledata_outlined,
              size: 50,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
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
                    const Row(
                      children: [
                        SizeCheckBox(
                          size: 'S',
                        ),
                        SizeCheckBox(
                          size: 'M',
                        ),
                        SizeCheckBox(
                          size: 'L',
                        ),
                        SizeCheckBox(
                          size: 'XL',
                        ),
                        SizeCheckBox(
                          size: 'XXL',
                        ),
                        SizeCheckBox(
                          size: '3XL',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              BottomProductDetail(
                mySecondaryTextStyle: mySecondaryTextStyle,
                objPro: widget.objPro,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
