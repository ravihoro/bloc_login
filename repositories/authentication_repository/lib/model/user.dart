import 'package:meta/meta.dart';

class User {
  final String name;
  final String email;
  final String password;

  const User(
      {@required this.name, @required this.email, @required this.password});

  static const empty = User(name: '', email: '', password: '');
}

class UserModel {
  static List<User> _users = [];

  static addUser(String name, String email, String password) {
    User user = User(email: email, name: name, password: password);
    _users.add(user);
  }

  static bool checkUserExists(String email) {
    for (User user in _users) {
      if (user.email == email) return true;
    }
    return false;
  }

  static User getUser(String email) {
    for (User user in _users) {
      if (user.email == email) return user;
    }
    return User.empty;
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}
