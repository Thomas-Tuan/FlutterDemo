import 'package:flutter/material.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/page/categories/categorybody.dart';

class MyCategoryGridList extends StatefulWidget {
  final List<Category> categoryFilter;
  const MyCategoryGridList({Key? key, required this.categoryFilter})
      : super(key: key);

  @override
  State<MyCategoryGridList> createState() => _MyCategoryGridListState();
}

class _MyCategoryGridListState extends State<MyCategoryGridList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.categoryFilter.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, idx) {
          return itemCategoryGridView(widget.categoryFilter[idx], context);
        });
  }
}
