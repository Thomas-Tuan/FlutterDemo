import 'package:flutter/material.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:myapp/mainpage.dart';
import 'package:myapp/page/carts/cart_dialog_body.dart';
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
    showDialogCheckout() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return CheckoutView(
              cartProvider: cartProvider,
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Giỏ hàng",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
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
      body: cartProvider.cartItemCount <= 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Giỏ hàng đang trống !',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Mainpage()));
                      },
                      text: "Quay về trang chủ".toUpperCase()),
                ],
              ),
            )
          : GradientBackground(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 300,
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
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(product.productName.toString()),
                                    Row(
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            cartProvider
                                                .decrementQuantity(index);
                                          },
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            size: 24,
                                          ),
                                        ),
                                        Text(
                                          product.quantity.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            cartProvider
                                                .incrementQuantity(index);
                                          },
                                          icon: Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Common.formatMoneyCurrency(
                                          product.unitPrice.toString()),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cartProvider.removeItem(index);
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 36),
                                        child: Text(
                                          "Xóa",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                contentPadding: EdgeInsets.zero,
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    product.productDetails,
                                  ),
                                ),
                                titleTextStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 25,
                        right: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Thông tin đơn hàng',
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              showDialogCheckout();
                            },
                          ),
                        ],
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
                        fontSize: 18,
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
                                  fontSize: 18,
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
                                  fontSize: 18,
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
                                  fontSize: 18,
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
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
