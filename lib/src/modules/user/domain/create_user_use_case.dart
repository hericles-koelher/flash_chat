import 'package:flash_chat/src/modules/user/domain/user_entity.dart';
import 'package:flash_chat/src/modules/user/infra/user_repository.dart';

abstract class ICreateUserUseCase {
  Future<UserEntity> call({
    required String uid,
    required String username,
    required String email,
  });
}

class CreateUserUseCase implements ICreateUserUseCase {
  final UserRepository userRepository;

  CreateUserUseCase(this.userRepository);

  @override
  Future<UserEntity> call({
    required String uid,
    required String username,
    required String email,
  }) {
    var userEntity = UserEntity(
      displayName: username,
      email: email,
      photoUrl: "",
      uid: uid,
      chats: [],
    );

    return userRepository.create(userEntity);
  }
}
