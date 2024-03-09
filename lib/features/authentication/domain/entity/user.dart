import 'package:bloc_login/features/authentication/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  static const empty = User(
    id: '',
    name: '',
    email: '',
  );

  factory User.fromUserModel(UserModel user) {
    return User(id: user.id, name: user.name, email: user.email);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
      ];
}
