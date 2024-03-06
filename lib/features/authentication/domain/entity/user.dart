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

  @override
  List<Object?> get props => [
        id,
        name,
        email,
      ];
}
