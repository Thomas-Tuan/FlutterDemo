import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/api/sharepre.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/data/provider/productprovider.dart';
import 'package:myapp/page/product/productbody.dart';
import 'package:provider/provider.dart';

class CRUDProduct extends StatefulWidget {
  const CRUDProduct({super.key});

  @override
  State<CRUDProduct> createState() => _CRUDProductState();
}

class _CRUDProductState extends State<CRUDProduct> {
  File? _imageFile;
  List<Category> categories = [];
  Category? selectedCategory;
  String? srcImgPro;

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

  void _showProductDialog(BuildContext context, {Product? product}) {
    final String formattedPrice = product?.price != null
        ? Common.formatMoneyCurrency(product!.price.toString())
        : '';
    final productNameController = TextEditingController(
      text: product != null ? product.name : '',
    );
    final productDesController = TextEditingController(
      text: product != null ? product.des : '',
    );
    final productPriceController = TextEditingController(
      text: formattedPrice,
    );
    srcImgPro = product != null ? product.img : '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product == null ? "Thêm sản phẩm" : "Cập nhật sản phẩm"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: productNameController,
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
                      labelText: "Tên sản phẩm"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: productDesController,
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
                      labelText: "Mô tả sản phẩm"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: productPriceController,
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
                      labelText: "Giá sản phẩm"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              offset: const Offset(0, 4),
                              blurRadius: 5,
                            ),
                          ]),
                      child: DropdownButton<Category>(
                        value: selectedCategory,
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category.name!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    selectedCategory != null
                        ? Expanded(
                            child: Text(
                              'Danh mục chọn : ${selectedCategory!.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
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
                      srcImgPro,
                    )),
                const SizedBox(
                  height: 20,
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
                    final productProvider =
                        Provider.of<ProductProvider>(context, listen: false);

                    if (product == null) {
                      productProvider.addProduct(
                        productNameController.text,
                        productDesController.text,
                        _imageFile,
                        double.parse(productPriceController.text),
                        selectedCategory?.id ?? 0,
                      );
                    } else {
                      productProvider.editProduct(
                        product.id!,
                        productNameController.text,
                        productDesController.text,
                        _imageFile,
                        double.parse(productPriceController.text),
                        selectedCategory?.id ?? 0,
                        srcImgPro!,
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

  Future<void> fetchCategories() async {
    categories = await APIRepository().fetchCategories();
    setState(() {
      selectedCategory = categories.isNotEmpty ? categories.first : null;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách sản phẩm",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: GradientBackground(
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            if (productProvider.product.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: productProvider.product.length,
              itemBuilder: (context, index) {
                final product = productProvider.product[index];
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
                            product.img!,
                            fit: BoxFit.contain,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            product.name!,
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
                              _showProductDialog(context, product: product);
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
                              productProvider.delProduct(product.id!);
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
          _showProductDialog(context);
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
