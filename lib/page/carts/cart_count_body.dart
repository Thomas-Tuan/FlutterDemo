import 'package:flutter/material.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:provider/provider.dart';

class CartIconWithCount extends StatelessWidget {
  const CartIconWithCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_bag,
              size: 30, color: Theme.of(context).colorScheme.secondary),
          onPressed: () {},
        ),
        if (cartProvider.cartItemCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary, // Badge background color
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                '${cartProvider.cartItemCount}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
