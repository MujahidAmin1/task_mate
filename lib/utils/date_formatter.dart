import 'package:intl/intl.dart';

class DateFormatter {
  static String toOrdinalDate(DateTime date) {
    final suffix = _getOrdinalSuffix(date.day);
    return '${DateFormat('EEEE').format(date)}, ${date.day}$suffix ${DateFormat('MMMM yyyy').format(date)}';
  }

  static String _getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }
}