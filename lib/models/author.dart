import 'package:meta/meta.dart';

class Author {
  int id;
  final String email;
  final String firstName;
  final String lastName;
  String token;
  String avatar;

  Author({
    this.id,
    this.token,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.avatar,
  });

  Author.fromMap(Map<String, dynamic> map)
      : assert(map['author_id'] != null),
        assert(map['author_email'] != null),
        id = map['author_id'],
        firstName = map['first_name'],
        lastName = map['last_name'],
        email = map['author_email'],
        avatar = map['avatar'],
        token = map['token'];
}
