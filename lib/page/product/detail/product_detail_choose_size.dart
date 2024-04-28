import 'package:flutter/material.dart';

class SizeCheckBox extends StatelessWidget {
  final String size;
  final String? selectedSize;
  final ValueChanged<String> onSelect;

  const SizeCheckBox({
    super.key,
    required this.size,
    required this.selectedSize,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedSize == size;

    return GestureDetector(
      onTap: () => onSelect(size),
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.inversePrimary
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.tertiary,
              blurRadius: 2,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
