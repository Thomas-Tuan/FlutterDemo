import 'package:flutter/material.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/conf/const.dart';

class QASizeWidget extends StatefulWidget {
  const QASizeWidget({super.key});

  @override
  State<QASizeWidget> createState() => _QASizeWidgetState();
}

class _QASizeWidgetState extends State<QASizeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Huớng dẫn chọn Size",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Khi đi mua quần áo thì chọn được món đồ chuẩn size vừa vặn luôn là đẹp nhất. Thấu hiểu điều đó, trên mỗi sản phẩm của Yody đều có bảng tính size số giúp khách hàng dễ dàng tìm được size số phù hợp với chiều cao và cân nặng. Cùng tìm hiểu bạn nhé!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Mỗi người chúng ta có những đặc điểm hình dáng cơ thể khác nhau, vì vậy size số mà bảng tính gợi ý có thể chưa phù hợp với một số người. Để chắc xác định chính xác size số quần áo của mình tại Yody bạn có thể tham khảo thêm bảng thông số dưới đây nhé!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Thông số chọn size theo cân nặng và chiều cao tham khảo theo bảng:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        offset: const Offset(0, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.asset(
                      '$urlImg' 'image 42.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        offset: const Offset(0, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.asset(
                      '$urlImg' 'image 43.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        offset: const Offset(0, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.asset(
                      '$urlImg' 'image 45.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        offset: const Offset(0, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.asset(
                      '$urlImg' 'image 46.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
