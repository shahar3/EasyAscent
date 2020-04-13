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

  static String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
