abstract class FlashChatAuthException implements Exception {
  final String message;

  FlashChatAuthException(this.message);
}

class InvalidCredentialsException extends FlashChatAuthException {
  InvalidCredentialsException(String message) : super(message);
}

class UserNotFoundException extends FlashChatAuthException {
  UserNotFoundException(String message) : super(message);
}