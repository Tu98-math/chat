import 'package:meta/meta.dart';

/// A class that represents user.
@immutable
class UserModel {
  /// Creates a user.
  const UserModel({
    this.createdAt,
    required this.firstName,
    required this.id,
    required this.imageUrl,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  UserModel copyWith({
    String? firstName,
    String? imageUrl,
    String? lastName,
    int? lastSeen,
    Map<String, dynamic>? metadata,
    int? updatedAt,
  }) {
    return UserModel(
      firstName: firstName,
      id: id,
      imageUrl: imageUrl,
      lastName: lastName,
    );
  }

  /// Created user timestamp, in ms
  final int? createdAt;

  /// First name of the user
  final String? firstName;

  /// Unique ID of the user
  final String id;

  /// Remote image URL representing user's avatar
  final String? imageUrl;

  /// Last name of the user
  final String? lastName;
}

UserModel _$UserFromJson(Map<String, dynamic> json) => UserModel(
      createdAt: json['createdAt'] as int?,
      firstName: json['firstName'] as String?,
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$UserToJson(UserModel instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'firstName': instance.firstName,
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'lastName': instance.lastName,
    };
