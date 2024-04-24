import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Common {
  static String shortText(String title, int num) {
    if (title.length <= num) {
      return title;
    } else {
      return "${title.substring(0, num)}...";
    }
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    return phoneNumber;
  }

  static String formatMoneyCurrency(String money) {
    double moneyValue = double.tryParse(money) ?? 0.0;
    return "${NumberFormat('###,###,###').format(moneyValue)} Đ";
  }

  static String formatCurrentDay() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return formattedDate;
  }

  static String getGender(int gender) {
    if (gender == 1) {
      return "Nam";
    } else {
      return "Nữ ";
    }
  }
}

class AlertDialogHelper {
  static void showAlertDialog({
    required BuildContext context,
    String? title,
    required String content,
    required String buttonText,
    VoidCallback? onButtonPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null
            ? Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        content: Text(
          content,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: onButtonPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
