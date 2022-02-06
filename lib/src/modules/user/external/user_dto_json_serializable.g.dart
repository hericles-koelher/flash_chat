// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto_json_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTOJsonSerializable _$UserDTOJsonSerializableFromJson(
        Map<String, dynamic> json) =>
    UserDTOJsonSerializable(
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      uid: json['uid'] as String,
      chats: (json['chats'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserDTOJsonSerializableToJson(
        UserDTOJsonSerializable instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'uid': instance.uid,
      'chats': instance.chats,
    };
