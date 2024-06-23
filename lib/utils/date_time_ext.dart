import 'package:intl/intl.dart';

extension DateTimeExt on DateTime? {
  String getDateTime({String format = 'dd MMM yyyy'})  {
    return DateFormat(format).format(this ?? DateTime.now());
  }
}