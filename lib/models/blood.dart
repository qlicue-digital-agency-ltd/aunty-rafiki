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
    this.uid,
  });
  final int id;
  final Level level;
  final Status status;
  final String title;
  final String subtitle;
  final String uid;
  final double quantity;
  final DateTime date;
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  Blood.fromMap(Map<String, dynamic> map)
      : assert(map['bloodLevel_id'] != null),
        id = map['bloodLevel_id'],
        title = map['bloodLevel_title'],
        subtitle = map['bloodLevel_subtitle'],
        uid = map['bloodLevel_uid'],
        date = DateTime.parse(map['bloodLevel_date']),
        quantity = double.parse(map['bloodLevel_quantity'].toString()),
        level = map['bloodLevel_level'] == "normal" ? Level.normal : Level.low,
        status = map['bloodLevel_status'] == "veryWeak"
            ? Status.veryWeak
            : (map['status'] == "weak"
                ? Status.weak
                : (map['status'] == "good")
                    ? Status.good
                    : (map['status'] == "veryGood")
                        ? Status.veryGood
                        : Status.excellent);
}
