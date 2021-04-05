import 'img.dart';

class Timeline {
  const Timeline({
    this.id,
    this.time,
    this.body,
    this.images,
  });
  final int id;
  final String body;
  final List<Img> images;
  final int time;

  Timeline.fromMap(Map<String, dynamic> map)
      : assert(map['timeline_id'] != null),
        id = map['timeline_id'],
        time = map['timeline_time'],
        body = map['timeline_body'],
        images = map['images'] != null
            ? (map['images'] as List).map((i) => Img.fromMap(i)).toList()
            : null;
}
