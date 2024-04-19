import 'package:flutter/material.dart';

class SizeCheckBox extends StatefulWidget {
  final String size;
  const SizeCheckBox({super.key, required this.size});

  @override
  State<SizeCheckBox> createState() => _SizeCheckBoxState();
}

class _SizeCheckBoxState extends State<SizeCheckBox> {
  List<String> selectedSizes = [];
  void toggleSizeSelection(String size) {
    setState(() {
      if (selectedSizes.contains(size)) {
        selectedSizes.remove(size);
      } else {
        selectedSizes.add(size);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedSizes.contains(widget.size);

    return GestureDetector(
      onTap: () => toggleSizeSelection(widget.size),
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
          widget.size,
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
