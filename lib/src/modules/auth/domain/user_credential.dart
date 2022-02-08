abstract class UserCredential {}

class EmailCredential extends UserCredential {
  final String email;
  final String password;

  EmailCredential({
    required this.email,
    required this.password,
  });

  bool validate() => true;
}
