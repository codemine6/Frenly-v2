import 'package:frenly/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> getAuthStatus() {
    return remoteDataSource.getAuthStatus();
  }

  @override
  Future<UserEntity> signInUser(UserEntity user) {
    return remoteDataSource.signInUser(user);
  }

  @override
  Future<void> signOutUser() {
    return remoteDataSource.signOutUser();
  }

  @override
  Future<void> signUpUser(UserEntity user) {
    return remoteDataSource.signUpUser(user);
  }
}
