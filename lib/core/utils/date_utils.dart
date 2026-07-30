/// Calendar helpers used by Daily Goals, Progress and Memory Engine.
abstract final class KompasDateUtils {
  /// Start of local calendar day for [date].
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Inclusive calendar-day difference between [from] and [to].
  static int calendarDaysBetween(DateTime from, DateTime to) {
    final a = startOfDay(from);
    final b = startOfDay(to);
    return b.difference(a).inDays;
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static String dayKey(DateTime date) {
    final d = startOfDay(date);
    final month = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$month-$day';
  }
}
