// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      isOnline: json['isOnline'] as bool,
      password: json['password'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'fullname': instance.fullname,
      'email': instance.email,
      'password': instance.password,
      'imageUrl': instance.imageUrl,
      'isOnline': instance.isOnline,
    };
