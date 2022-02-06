import 'user_dto.dart';

abstract class IUserDatasource {
  Future<UserDTO> create(UserDTO dto);

  Future<UserDTO?> getByUID(String uid);
}
