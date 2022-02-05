class UserEntity {
  final String displayName;
  final String phoneNumber;
  final String photoUrl;
  final String uid;
  final List<String> chats;

  UserEntity({
    required this.displayName,
    required this.phoneNumber,
    required this.photoUrl,
    required this.uid,
    required this.chats,
  });

  UserEntity copyWith({
    String? displayName,
    String? phoneNumber,
    String? photoUrl,
    String? uid,
    List<String>? chats,
  }) {
    return UserEntity(
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
      chats: chats ?? this.chats,
    );
  }
}
