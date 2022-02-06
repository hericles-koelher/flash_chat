import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../infra/user_datasource_interface.dart';
import '../infra/user_dto.dart';
import 'user_dto_json_serializable.dart';

class FirebaseUserDatasource implements IUserDatasource {
  late final FirebaseFirestore firestore;
  late final CollectionReference users;

  void init() {
    var firebaseApp = Firebase.app("Flash Chat");

    firestore = FirebaseFirestore.instanceFor(app: firebaseApp);

    users = firestore.collection("users");
  }

  @override
  Future<UserDTO> create(covariant UserDTOJsonSerializable dto) async {
    // TODO: setup a default profile image.

    await users.doc(dto.uid).set(
          dto.toJson(),
        );

    return dto;
  }

  @override
  Future<UserDTO?> getByUID(String uid) {
    // TODO: implement getByUID
    throw UnimplementedError();
  }
}