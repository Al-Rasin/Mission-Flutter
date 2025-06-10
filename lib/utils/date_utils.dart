class DateUtilsHelper {
  static String formatDate(DateTime date) {
    return "[32m${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}[0m";
  }
}
