import 'package:flutter/material.dart';
import 'package:myapp/component/my_button.dart';
import 'package:myapp/data/provider/productprovider.dart';
import 'package:myapp/page/product/productfilterwidget.dart';
import 'package:provider/provider.dart';

class FilterProductDrawer extends StatefulWidget {
  const FilterProductDrawer({super.key});

  @override
  State<FilterProductDrawer> createState() => _FilterProductDrawerState();
}

class _FilterProductDrawerState extends State<FilterProductDrawer> {
  final Map<String, bool> _sizeFilters = {
    'L': false,
    'XL': false,
    'XXL': false,
    '3XL': false,
  };
  String formatWithSeparator(int value) {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'),
          (match) => '${match[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<ProductProvider>(context);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      size: 24,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Bộ lọc ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Giá',
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (var entry in filterProvider.priceFilters.entries)
              CheckboxListTile(
                title: Text(
                  '${formatWithSeparator(entry.value['min']!)} - ${formatWithSeparator(entry.value['max'] ?? double.infinity.toInt())} Đ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: filterProvider.selectedPriceFilters[entry.key],
                onChanged: (bool? value) {
                  filterProvider.updatePriceFilter(entry.key, value ?? false);
                },
              ),
            const SizedBox(height: 16),
            Divider(
              indent: 40,
              endIndent: 40,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            Text(
              'Size',
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (var size in _sizeFilters.entries)
              CheckboxListTile(
                title: Text(size.key),
                value: size.value,
                onChanged: (bool? value) {
                  setState(() {
                    _sizeFilters[size.key] = value!;
                  });
                },
              ),
            const SizedBox(height: 16),
            MyButton(
              onTap: () {
                final selectedPriceFilters =
                    filterProvider.getSelectedPriceRanges();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductFilterWidget(
                      priceFilters: selectedPriceFilters,
                    ),
                  ),
                );
              },
              text: 'Xác nhận lọc',
            ),
          ],
        ),
      ),
    );
  }
}
