import 'package:intl/intl.dart';

String formateDate(DateTime dateTime){
  return DateFormat('MMMM d, yyyy').format(dateTime);
}