import 'package:flutter/material.dart';
import 'package:myapp/page/carts/cartwidget.dart';
import 'package:myapp/page/product/product_filter_name_widget.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController nameController;
  final Function(String) onSearch;
  const MyAppBar({
    Key? key,
    required this.nameController,
    required this.onSearch,
  }) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: TextField(
          controller: nameController,
          onChanged: onSearch,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              hintText: 'Tìm kiếm sản phẩm...',
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondary,
              prefixIcon: IconButton(
                onPressed: () {
                  final searchText = nameController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductFilterWithNameWidget(searchText: searchText),
                    ),
                  );
                },
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
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
                fontSize: 17,
              )),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartWidget())),
          icon: Icon(
            Icons.shopping_bag,
            size: 30,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
