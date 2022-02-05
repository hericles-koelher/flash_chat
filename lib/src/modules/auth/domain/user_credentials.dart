abstract class UserCredentials {}

class PhoneCredentials extends UserCredentials {
  final String phone;

  PhoneCredentials(this.phone);

  // TODO: validate phone later...
  bool validate() => true;
}
