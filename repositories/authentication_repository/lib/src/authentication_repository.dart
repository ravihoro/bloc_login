import '../model/user.dart';
import 'package:meta/meta.dart';

class AuthenticationRepository {
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
}
