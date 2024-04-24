import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/data/provider/categoryprovider.dart';
import 'package:myapp/page/categories/categorybody.dart';
import 'package:provider/provider.dart';

class CRUDCate extends StatefulWidget {
  const CRUDCate({super.key});

  @override
  State<CRUDCate> createState() => _CRUDCateState();
}

class _CRUDCateState extends State<CRUDCate> {
  File? _imageFile;

  Future<void> _selectImage(BuildContext context) async {
    final selectedFile = await pickImageFromGallery();
    if (selectedFile != null) {
      setState(() {
        _imageFile = selectedFile;
      });
      // ignore: use_build_context_synchronously
      AlertDialogHelper.showAlertDialog(
        context: context,
        content: 'Thêm hình thành công',
        buttonText: 'OK',
        onButtonPressed: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  void _showCategoryDialog(BuildContext context, {Category? category}) {
    final categoryNameController = TextEditingController(
      text: category != null ? category.name : '',
    );
    final categoryDesController = TextEditingController(
      text: category != null ? category.des : '',
    );
    String? srcImgCate = category != null ? category.img : '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(category == null ? "Thêm danh mục" : "Cập nhật danh mục"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: categoryNameController,
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
                      labelText: "Tên danh mục"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: categoryDesController,
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
                      labelText: "Mô tả danh mục"),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      _selectImage(context);
                    },
                    child: displayImage(
                      context,
                      _imageFile,
                      srcImgCate,
                    )),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "Hủy bỏ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    final categoryProvider =
                        Provider.of<CategoryProvider>(context, listen: false);

                    if (category == null) {
                      categoryProvider.addCategory(
                        categoryNameController.text,
                        categoryDesController.text,
                        _imageFile,
                      );
                    } else {
                      categoryProvider.editCategory(
                        category.id!,
                        categoryNameController.text,
                        categoryDesController.text,
                        _imageFile,
                      );
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "Lưu",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách danh mục",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: GradientBackground(
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
            if (categoryProvider.categories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: categoryProvider.categories.length,
              itemBuilder: (context, index) {
                final category = categoryProvider.categories[index];
                return Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(
                    left: 25,
                    top: 10,
                    right: 25,
                  ),
                  padding: const EdgeInsets.all(25),
                  child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.primary,
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
                          child: Image.network(
                            category.img!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            category.name!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.background),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            onPressed: () {
                              _showCategoryDialog(context, category: category);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.background),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            onPressed: () {
                              categoryProvider.delCategory(category.id!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCategoryDialog(context);
        },
        tooltip: 'Add Category',
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
