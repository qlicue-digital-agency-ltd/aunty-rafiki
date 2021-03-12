import 'package:aunty_rafiki/models/profile.dart';
import 'package:meta/meta.dart';

class Author {
  int id;
  final String email;
  final String name;
  String token;
  Profile profile;

  Author({
    this.id,
    this.token,
    @required this.email,
    @required this.name,
    this.profile,
    uid,
  });

  Author.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['email'] != null),
        id = map['id'],
        token = map['token'].toString(),
        email = map['email'].toString(),
        name = map['name'].toString(),
        profile = Profile.fromMap(map['profile']);
}
