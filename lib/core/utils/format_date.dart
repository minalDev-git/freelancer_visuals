import 'package:intl/intl.dart';

String formatDateddMMMYYYY(DateTime date) {
  return DateFormat("dd MMM, yyyy").format(date);
}
