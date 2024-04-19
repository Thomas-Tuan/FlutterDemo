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
}
