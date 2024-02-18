import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toYyyyMmDdHhMmSs() => DateFormat('yyyy/MM/dd HH:mm:ss').format(this);
}
