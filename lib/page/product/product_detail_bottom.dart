import 'package:flutter/material.dart';

class BottomProductDetail extends StatelessWidget {
  const BottomProductDetail({
    super.key,
    required this.mySecondaryTextStyle,
  });

  final TextStyle mySecondaryTextStyle;

  @override
  Widget build(BuildContext context) {
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
