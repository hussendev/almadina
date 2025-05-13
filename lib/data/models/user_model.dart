import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String mobile;

  @HiveField(4)
  final String? email;

  @HiveField(5)
  final String password;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobile: json['phone'],
      password: json['password'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'mobile': mobile,
      'email': email,
      'password': password,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}