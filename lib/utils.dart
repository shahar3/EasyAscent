import 'package:intl/intl.dart';

class Utils {
  static bool isToday(DateTime date) {
    DateTime today = DateTime.now();
    return date.day == today.day &&
        date.month == today.month &&
        date.year == today.year;
  }

  static bool isTheSameDate(DateTime date, DateTime otherDate) {
    return date.day == otherDate.day &&
        date.month == otherDate.month &&
        date.year == otherDate.year;
  }

  static String formattedDateTitle(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
