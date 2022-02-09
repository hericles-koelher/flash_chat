abstract class FlashChatException implements Exception {
  final String message;

  FlashChatException(this.message);
}

class InvalidCredentialException extends FlashChatException {
  InvalidCredentialException(String message) : super(message);
}

class UserNotFoundException extends FlashChatException {
  UserNotFoundException(String message) : super(message);
}
