import 'package:equatable/equatable.dart';

class ResponseModel<T> extends Equatable {
  final bool isSuccess;
  final String? message;
  final T? data;

  ResponseModel({
    this.isSuccess = false,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json,
          T Function(Map<String, dynamic>) fromJson) =>
      ResponseModel(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: fromJson(json["data"]),
      );

  Map<String, dynamic> toJson(Map<String, dynamic>? Function(T?) toJson) => {
        "isSuccess": isSuccess,
        "message": message,
        "data": toJson(data),
      };

  @override
  List<Object?> get props => [
        isSuccess,
        message,
        data,
      ];
}
