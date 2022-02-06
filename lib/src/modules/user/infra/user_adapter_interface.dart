import '../domain/user_entity.dart';
import 'user_dto.dart';

abstract class IUserAdapter {
  UserEntity getUserEntityFromUserDTO(UserDTO dto);

  UserDTO getUserDTOFromUserEntity(UserEntity entity);
}
