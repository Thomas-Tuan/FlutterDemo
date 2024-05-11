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
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary,
              blurRadius: 2,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              fontSize: 18,
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
