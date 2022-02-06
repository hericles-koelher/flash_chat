import '../domain/user_entity.dart';
import '../infra/user_adapter_interface.dart';
import '../infra/user_dto.dart';
import 'user_dto_json_serializable.dart';

class UserAdapter implements IUserAdapter {
  @override
  UserDTO getUserDTOFromUserEntity(UserEntity entity) {
    return UserDTOJsonSerializable(
      displayName: entity.displayName,
      email: entity.email,
      photoUrl: entity.photoUrl,
      uid: entity.uid,
      chats: entity.chats,
    );
  }

  @override
  UserEntity getUserEntityFromUserDTO(UserDTO dto) {
    return UserEntity(
      displayName: dto.displayName,
      email: dto.email,
      photoUrl: dto.photoUrl,
      uid: dto.uid,
      chats: dto.chats,
    );
  }
}
