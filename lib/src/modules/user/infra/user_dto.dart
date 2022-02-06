abstract class UserDTO {
  final String displayName;
  final String email;
  final String photoUrl;
  final String uid;
  final List<String> chats;

  UserDTO(
    this.displayName,
    this.email,
    this.photoUrl,
    this.uid,
    this.chats,
  );
}
