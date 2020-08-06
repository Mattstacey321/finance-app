import 'package:timeago/timeago.dart' as timeago;

bool isDifference({String compareTime}) {
  print("debug: time by key ${DateTime.parse(compareTime)}");
  return DateTime.parse(compareTime).difference(DateTime.now()).inDays == 0 &&
      DateTime.parse(compareTime).day == DateTime.now().day;
}
String toNow(DateTime date){
  var locale = 'en';
  return timeago.format(date.subtract(new Duration(minutes: 1)), locale: locale);
}
