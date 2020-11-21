class Timeline {
  const Timeline({
    this.id,
    this.time,
    this.body,
    this.image,
  });
  final int id;
  final String body;
  final String image;
  final int time;

  Timeline.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        time = map['time'],
        image = map['image'],
        body = map['body'];
}
