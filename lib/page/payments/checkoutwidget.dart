import 'package:flutter/material.dart';
import 'package:myapp/conf/const.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
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
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Thanh Toán',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      //Chỗ này để chèn hình vào
                      child: SizedBox(
                        child: Image.asset(
                          '$urlCartPageImg' 'image-21.png',
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Áo Polo Nam \nMàu - Size: Xanh / L \n\n\nGiá: 350:000đ         Số Lượng: 1',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Ghi chú",
                    hintText: "Nhập ghi chú...",
                    icon: Icon(Icons.note),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Mã giảm giá",
                    hintText: "Nhập mã giảm giá...",
                    icon: Icon(Icons.discount),
                  ),
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
                      child: Text("Tạm tính (1 sản phẩm)"),
                    ),
                    Expanded(
                      child: Text(textAlign: TextAlign.right, "357.000đ"),
                    ),
                  ],
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
                      child: Text(textAlign: TextAlign.right, "20.000đ"),
                    ),
                  ],
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text('Tổng tiền thanh toán',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.right,
                        '377.000d',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                    minimumSize: MaterialStateProperty.all(const Size(350, 50)),
                    elevation: MaterialStateProperty.all<double>(10.0),
                    // Thiết lập khoảng cách nội dung của nút đến viền
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                    // Các thuộc tính khác tùy chỉnh nút
                  ),
                  child: Text(
                    'Thanh Toán',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
