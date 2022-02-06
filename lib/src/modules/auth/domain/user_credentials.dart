abstract class UserCredentials {}

class CredentialForEmailSignIn extends UserCredentials {
  final String email;
  final String password;

  CredentialForEmailSignIn({
    required this.email,
    required this.password,
  });

  bool validate() => true;
}

class CredentialForEmailSignUp extends UserCredentials {
  final String displayName;
  final String email;
  final String password;

  CredentialForEmailSignUp({
    required this.displayName,
    required this.email,
    required this.password,
  });

  bool validate() => true;
}
