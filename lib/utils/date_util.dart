import 'package:intl/intl.dart';

String getWeekMonthDay(String dateStr) {
  return DateFormat("EEEE, MMMM dd").format(DateTime.parse(dateStr));
}

String getWeek(String dateStr) {
  String today = DateFormat("EE").format(DateTime.now());
  String formattedDate = DateFormat("EE").format(DateTime.parse(dateStr));

  return today == formattedDate ? "Today" : formattedDate;
}
