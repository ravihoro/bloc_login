import '../model/user.dart';
import 'package:meta/meta.dart';
import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _userController = StreamController<User>();

  Stream<User> get user async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield User.empty;
    yield* _userController.stream;
  }

  Future<bool> login(
      {@required String email, @required String password}) async {
    bool userPresent = false;
    await Future<void>.delayed(const Duration(milliseconds: 300), () {
      User user = UserModel.getUser(email);
      if (user == User.empty)
        userPresent = false;
      else {
        _userController.add(UserModel.getUser(email));
        userPresent = true;
      }
    });
    return userPresent;
  }

  void logOut() {
    _userController.add(User.empty);
  }

  bool signUp({
    @required String name,
    @required String email,
    @required String password,
  }) {
    if (!UserModel.checkUserExists(email)) {
      UserModel.addUser(name, email, password);
      return true;
    }
    return false;
  }

  void dispose() {
    _userController.close();
  }
}
