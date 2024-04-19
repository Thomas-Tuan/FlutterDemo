import 'package:flutter/material.dart';

class ColorSelect extends StatefulWidget {
  const ColorSelect({super.key});

  @override
  State<ColorSelect> createState() => _ColorSelectState();
}

class _ColorSelectState extends State<ColorSelect> {
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Màu sắc:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 10),
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
          child: DropdownButton<String>(
            value: selectedColor ?? 'Đen',
            items: <String>['Vàng', 'Tím', 'Trắng', 'Đen']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedColor = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
