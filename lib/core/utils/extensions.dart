import 'package:intl/intl.dart';

extension NumExt on num {
  String get formatToCurrency => NumberFormat("#,##0", "en_US").format(this);
}
