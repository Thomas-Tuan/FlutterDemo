import 'package:flutter/material.dart';

import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:myapp/page/carts/cartwidget.dart';
import 'package:provider/provider.dart';

class BottomProductDetail extends StatelessWidget {
  final Product objPro;
  const BottomProductDetail(
      {Key? key, required this.objPro, required this.mySecondaryTextStyle})
      : super(key: key);

  final TextStyle mySecondaryTextStyle;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(
                Icons.message_outlined,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              Text(
                'Nhắn tin',
                style: mySecondaryTextStyle,
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            cartProvider.addItem(objPro);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CartWidget()));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.shopping_cart_checkout,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                Text(
                  'Thêm vào giỏ',
                  style: mySecondaryTextStyle,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Mua ngay',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        )
      ],
    );
  }
}
