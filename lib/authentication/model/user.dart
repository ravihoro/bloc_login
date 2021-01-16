import 'package:meta/meta.dart';

class User {
  final String name;
  final String email;
  final String password;

  const User(
      {@required this.name, @required this.email, @required this.password});

  static const empty = User(name: '', email: '', password: '');
}

class UserList {
  List<User> _users = [];

  addUser(User user) {
    _users.add(user);
  }

  bool checkUserExists(String email) {
    for (User user in _users) {
      if (user.email == email) return true;
    }
    return false;
  }

  User getUser(String email) {
    for (User user in _users) {
      if (user.email == email) return user;
    }
    return User.empty;
  }
}
