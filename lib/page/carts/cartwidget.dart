import 'package:flutter/material.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:myapp/page/carts/cartbody.dart';
import 'package:myapp/page/payments/checkoutwidget.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Giỏ hàng",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            IconButton(
              onPressed: () {
                cartProvider.clearCart();
              },
              icon: Image.asset(
                '$urlCartPageImg' 'trash-can.png',
                width: 30,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: const [
          Row(
            children: [
              CartIconWithCount(),
            ],
          ), // Add the custom component for the cart icon with count
        ],
      ),
      body: cartProvider.cartItemCount <= 0
          ? const Center(
              child: Text(
                'Giỏ hàng đang trống !',
              ),
            )
          : GradientBackground(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 600,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          left: 25,
                          right: 25,
                        ),
                        child: ListView.builder(
                          itemCount: cartProvider.cartItemCount,
                          itemBuilder: (context, index) {
                            final product = cartProvider.cart.cartItem[index];
                            return ListTile(
                              leading: Image.network(
                                product.productDetails,
                              ),
                              title: Text(
                                product.productName!,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cartProvider.removeItem(index);
                                    },
                                    child: Text('Xóa',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          decorationThickness: 1,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                        )),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 30,
                                    // width: 30,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                                    child: IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          cartProvider.decrementQuantity(index);
                                        }),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      '${product.quantity}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cartProvider.incrementQuantity(index);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'CÓ THỂ BẠN MUỐN MUA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                '$urlCartPageImg' 'image-21.png',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Quần Âu nam cao cấp giữ phom, co giãn thoải mái',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '499.000 đ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                '$urlCartPageImg' 'image-22.png',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Áo polo nữ thể thao Airycool Basic, thoáng mát',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '392.000 đ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                '$urlImg' 'voucher.png',
                                width: 50,
                              ),
                              Text(
                                'Thêm mã giảm giá',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phí giao hàng',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                              Text(
                                '50.000 Đ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tổng cộng',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                              Text(
                                Common.formatMoneyCurrency(
                                    cartProvider.totalPrice.toString()),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyButton(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PaymentWidget()));
                              },
                              text: "Thanh toán".toUpperCase()),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
