import 'package:json_annotation/json_annotation.dart';

import '../infra/user_dto.dart';

part 'user_dto_json_serializable.g.dart';

@JsonSerializable()
class UserDTOJsonSerializable extends UserDTO {
  UserDTOJsonSerializable({
    required String displayName,
    required String email,
    required String photoUrl,
    required String uid,
    required List<String> chats,
  }) : super(displayName, email, photoUrl, uid, chats);

  factory UserDTOJsonSerializable.fromJson(Map<String, dynamic> json) =>
      _$UserDTOJsonSerializableFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOJsonSerializableToJson(this);

  UserDTO copyWith({
    String? displayName,
    String? email,
    String? photoUrl,
    String? uid,
    List<String>? chats,
  }) {
    return UserDTOJsonSerializable(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
      chats: chats ?? this.chats,
    );
  }
}
