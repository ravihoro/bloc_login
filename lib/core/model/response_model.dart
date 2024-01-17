import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:equatable/equatable.dart';

class ResponseModel extends Equatable {
  final bool? success;
  final String? message;
  final User? user;

  ResponseModel({
    this.success,
    this.message,
    this.user,
  });

  // factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
  //       success: json["success"],
  //       message: json["message"],
  //       user: json["user"] == null ? null : User.fromJson(json["user"]),
  //     );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "message": message,
  //       "user": user?.toJson(),
  //     };

  @override
  List<Object?> get props => [
        success,
        message,
        user,
      ];
}
