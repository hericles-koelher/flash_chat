abstract class FlashChatException implements Exception {
  final String message;

  FlashChatException(this.message);
}

class InvalidCredentialException extends FlashChatException {
  final String? emailMessage;
  final String? passwordMessage;

  InvalidCredentialException({
    required String message,
    this.emailMessage,
    this.passwordMessage,
  }) : super(message);

  InvalidCredentialException copyWith({
    String? message,
    String? emailMessage,
    String? passwordMessage,
  }) {
    return InvalidCredentialException(
      message: message ?? this.message,
      emailMessage: emailMessage ?? this.emailMessage,
      passwordMessage: passwordMessage ?? this.passwordMessage,
    );
  }
}

class DeleteAccountException extends FlashChatException {
  DeleteAccountException(String message) : super(message);
}
