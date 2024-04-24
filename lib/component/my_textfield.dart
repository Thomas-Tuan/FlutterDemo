// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController? passwordController;
  final String hinText;
  final bool obscureText;
  final IconData icon;
  final IconData? suffixIcon;

  const MyTextField({
    Key? key,
    required this.controller,
    this.passwordController,
    required this.hinText,
    required this.obscureText,
    required this.icon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;
  String? _errorMessage;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText ? _obscureText : false,
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
            hintText: widget.hinText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.w300,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            suffixIcon: widget.suffixIcon == Icons.confirmation_num_sharp
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : (widget.suffixIcon == Icons.calendar_today
                    ? IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2022),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                              widget.controller.text =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                            });
                          }
                        },
                      )
                    : null),
            errorText: _errorMessage,
            errorStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng không để trống';
          } else if (widget.hinText.toLowerCase().contains('số điện thoại')) {
            final RegExp phoneRegex = RegExp(r'^\d{1,10}$');
            if (value.length > 10) {
              return 'SĐT phải đúng 10 số !!!';
            }
            if (!phoneRegex.hasMatch(value)) {
              return 'SĐT không hợp lệ !!!';
            }
          } else if (widget.hinText.toLowerCase().contains('Number ID')) {
            return null;
          } else if (widget.hinText.contains('Mật khẩu')) {
            if (!(value.length >= 6)) {
              return 'Mật khẩu phải từ 6 kí tự';
            }
          } else if (widget.hinText.contains('Xác nhận mật khẩu')) {
            if (value != widget.passwordController!.text) {
              return 'Mật khẩu không khớp';
            }
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            _errorMessage = null;
          });
        },
      ),
    );
  }
}
