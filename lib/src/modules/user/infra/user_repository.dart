import 'package:flash_chat/src/modules/core/domain/flash_chat_exception.dart';

import '../domain/user_entity.dart';
import '../domain/user_repository_interface.dart';
import 'user_adapter_interface.dart';
import 'user_datasource_interface.dart';

class UserRepository implements IUserRepository {
  final IUserDatasource userDatasource;
  final IUserAdapter userAdapter;

  UserRepository({
    required this.userDatasource,
    required this.userAdapter,
  });

  @override
  Future<UserEntity> create(UserEntity user) async {
    var userDTO = await userDatasource.create(
      userAdapter.getUserDTOFromUserEntity(user),
    );

    return userAdapter.getUserEntityFromUserDTO(userDTO);
  }

  @override
  Future<UserEntity> getByUID(String uid) async {
    var userDTO = await userDatasource.getByUID(uid);

    if (userDTO != null) {
      return userAdapter.getUserEntityFromUserDTO(userDTO);
    } else {
      throw UserNotFoundException("User with UID '$uid' not found");
    }
  }
}
