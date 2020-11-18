import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:intl/intl.dart';

class Blood {
  const Blood({
    this.id,
    this.level,
    this.status,
    this.date,
    this.title,
    this.subtitle,
    this.quantity,
  });
  final int id;
  final Level level;
  final Status status;
  final String title;
  final String subtitle;
  final double quantity;
  final DateTime date;
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  Blood.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        title = map['title'],
        subtitle = map['subtitle'],
        date = DateTime.parse(map['date']),
        quantity = double.parse(map['quantity'].toString()),
        level = map['level'] == "normal" ? Level.normal : Level.low,
        status = map['status'] == "veryWeak"
            ? Status.veryWeak
            : (map['status'] == "weak"
                ? Status.weak
                : (map['status'] == "good")
                    ? Status.good
                    : (map['status'] == "veryGood")
                        ? Status.veryGood
                        : Status.excellent);
}
