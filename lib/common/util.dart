import 'package:intl/intl.dart';

class Util {
  static String dateFormat({required DateTime date}) {
    try {
      final df = DateFormat('EEEE, dd MMMM yyyy');
      return df.format(date);
    } catch (err) {
      return 'Invalid date';
    }
  }
}
