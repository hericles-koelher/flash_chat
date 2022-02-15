import 'package:flash_chat/src/modules/core/domain/flash_chat_exception.dart';
import 'package:validators/validators.dart';

abstract class UserCredential {}

class EmailCredential extends UserCredential {
  final String email;
  final String password;

  EmailCredential({
    required this.email,
    required this.password,
  });

  void validate() {
    var ex = InvalidCredentialException(
      message: "Invalid email and/or password",
    );

    if (!isEmail(email)) {
      ex = ex.copyWith(
        emailMessage: "Invalid email address",
      );
    }

    if (!isLength(password, 8)) {
      ex = ex.copyWith(
        passwordMessage: "Password must be at least 8 characters longer",
      );
    }

    if (ex.emailMessage != null || ex.passwordMessage != null) {
      throw ex;
    }
  }
}
