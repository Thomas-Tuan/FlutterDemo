import 'package:flutter/material.dart';
import 'package:myapp/page/carts/cartwidget.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 5,
        ),
        child: TextField(
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              hintText: 'Tìm kiếm sản phẩm...',
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondary,
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
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
                      color: Theme.of(context).colorScheme.tertiary)),
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w300,
                fontSize: 15,
              )),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartWidget())),
          icon: Icon(
            Icons.shopping_bag,
            size: 40,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
