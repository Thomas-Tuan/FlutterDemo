import 'package:flutter/material.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:myapp/mainpage.dart';
import 'package:provider/provider.dart';

class SuccessPage extends StatelessWidget {
  final String message;
  final String? additionalInfo;
  final dynamic ojbPro;
  const SuccessPage({
    Key? key,
    required this.message,
    this.additionalInfo,
    this.ojbPro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết thanh toán",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 200,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ojbPro != null
                  ? Row(
                      children: [
                        SizedBox(
                          child: Image.network(
                            ojbPro.img,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ojbPro.name.toString(),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Common.formatMoneyCurrency(
                                      ojbPro.price.toString(),
                                    ),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'Số lượng: 1',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: cartProvider.cartItemCount,
                        itemBuilder: (context, index) {
                          final product = cartProvider.cart.cartItem[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  offset: const Offset(0, 4),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  child: Image.network(
                                    product.productDetails,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.productName.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Common.formatMoneyCurrency(
                                                product.unitPrice.toString()),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Số lượng: ${product.quantity.toString()}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              if (additionalInfo != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    additionalInfo!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 30),
              MyButton(
                  onTap: () {
                    cartProvider.clearCart();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Mainpage()));
                  },
                  text: "Quay về trang chủ".toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}
