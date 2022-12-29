import 'package:frenly/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> getAuthStatus();
  Future<UserEntity> signInUser(UserEntity user);
  Future<void> signOutUser();
  Future<void> signUpUser(UserEntity user);
}