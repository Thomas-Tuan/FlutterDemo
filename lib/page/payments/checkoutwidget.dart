import 'package:flutter/material.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:myapp/page/success_widget.dart';
import 'package:provider/provider.dart';

class PaymentWidget extends StatefulWidget {
  final Product? objProduct;
  const PaymentWidget({super.key, this.objProduct});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thanh toán",
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.objProduct != null
                    ? Row(
                        children: [
                          SizedBox(
                            child: Image.network(
                              widget.objProduct?.img ?? '',
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.objProduct?.name.toString() ?? '',
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
                                        widget.objProduct?.price.toString() ??
                                            '',
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
                Divider(
                  indent: 10,
                  endIndent: 10,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                TextFormField(
                  controller: noteController,
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        width: 3,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    hintText: 'Nhập ghi chú',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w300,
                    ),
                    prefixIcon: Icon(
                      Icons.note,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
                        color: Theme.of(context).colorScheme.inversePrimary,
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
                const SizedBox(height: 16),
                const Text(
                  "Chọn phương thức thanh toán",
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary),
                        ),
                        child: Text(
                          'Tiền mặt',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary),
                        ),
                        child: Text(
                          'Thanh toán Online',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text("Mã giảm giá"),
                    ),
                    Expanded(
                      child: Text(textAlign: TextAlign.right, "0đ"),
                    ),
                  ],
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text("Phí giao hàng"),
                    ),
                    Expanded(
                      child: Text(textAlign: TextAlign.right, "50.000đ"),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Text('Tổng tiền thanh toán',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(
                      child: Text(
                        Common.formatMoneyCurrency(
                            (cartProvider.totalPrice + 50000).toString()),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                MyButton(
                  onTap: () async {
                    String res =
                        await handleCheckout(widget.objProduct!, cartProvider);
                    if (res.contains('ok')) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuccessPage(
                              ojbPro: widget.objProduct,
                              message:
                                  "Đơn hàng của bạn đã được đặt thành công !",
                              additionalInfo:
                                  "Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi !",
                            ),
                          ));
                    }
                  },
                  text: 'Thanh Toán',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
