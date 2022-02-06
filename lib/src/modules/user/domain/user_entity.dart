class UserEntity {
  final String displayName;
  final String email;
  final String photoUrl;
  final String uid;
  final List<String> chats;

  UserEntity({
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.uid,
    required this.chats,
  });

  UserEntity copyWith({
    String? displayName,
    String? email,
    String? photoUrl,
    String? uid,
    List<String>? chats,
  }) {
    return UserEntity(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
      chats: chats ?? this.chats,
    );
  }
}
