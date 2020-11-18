import 'package:aunty_rafiki/constants/enums/enums.dart';

class Blood {
  const Blood({
    this.id,
    this.level,
    this.status,
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

  Blood.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        title = map['title'],
        subtitle = map['subtitle'],
        quantity = map['quantity'],
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

List<Blood> sampleBloodLevels = <Blood>[
  const Blood(
    quantity: 12.0,
    level: Level.low,
    status: Status.good,
    title: 'Low',
    subtitle: 'David Luiz brings his opponent down.',
  ),
  const Blood(
    quantity: 10.2,
    level: Level.normal,
    status: Status.veryGood,
    title: 'Normal',
    subtitle: 'This yellow card was deserved.',
  ),
  const Blood(
    quantity: 11.0,
    level: Level.low,
    status: Status.weak,
    title: 'Gooooaaaal!',
    subtitle:
        'Goal! Lionel Messi slams the ball into the open net from close range.',
  ),
  const Blood(
    quantity: 10.0,
    level: Level.low,
    status: Status.weak,
    title: 'One more!',
    subtitle: 'Piqué gets a yellow card for arguing with the referee.',
  ),
  const Blood(
    quantity: 9.0,
    level: Level.normal,
    status: Status.excellent,
    title: 'Ouchh',
    subtitle: 'Blood level.',
  ),
];
