import 'package:traka/core/models/base_model.dart';

class UserModel extends BaseModel {
  final String email;
  final String? image;
  final String firstName;

  UserModel(
      {required this.email, required this.image, required this.firstName});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'], image: json['image'], firstName: json['firstName']);

  @override
  Map<String, dynamic> toJson() =>
      {'email': email, 'image': image, 'firstName': firstName};
}
