import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:frenly/data/data_sources/remote/auth/auth_remote_data_source_impl.dart';
import 'package:frenly/data/data_sources/remote/post/post_remote_data_source.dart';
import 'package:frenly/data/data_sources/remote/post/post_remote_data_source_impl.dart';
import 'package:frenly/data/repositories/auth_repository_impl.dart';
import 'package:frenly/data/repositories/post_repository_impl.dart';
import 'package:frenly/domain/repositories/auth_repository.dart';
import 'package:frenly/domain/repositories/post_repository.dart';
import 'package:frenly/domain/usecases/auth/get_auth_status_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_in_user_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_out_user_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_up_user_usecase.dart';
import 'package:frenly/domain/usecases/post/create_post_usecase.dart';
import 'package:frenly/domain/usecases/post/get_posts_usecase.dart';
import 'package:frenly/domain/usecases/post/like_post_usecase.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  // Cubit
  getIt.registerFactory(() => AuthCubit(
        getAuthStatusUseCase: getIt.call(),
        signInUserUseCase: getIt.call(),
        signOutUserUseCase: getIt.call(),
        signUpUserUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => PostCubit(
        createPostUsecase: getIt.call(),
        getPostsUseCase: getIt.call(),
        likePostUseCase: getIt.call(),
      ));

  // UseCase
  getIt.registerLazySingleton(
      () => GetAuthStatusUseCase(repository: getIt.call()));
  getIt
      .registerLazySingleton(() => SignInUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => SignOutUserUseCase(repository: getIt.call()));
  getIt
      .registerLazySingleton(() => SignUpUserUseCase(repository: getIt.call()));
  getIt
      .registerLazySingleton(() => CreatePostUsecase(repository: getIt.call()));
  getIt.registerLazySingleton(() => GetPostsUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(() => LikePostUseCase(repository: getIt.call()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: getIt.call()));
  getIt.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(remoteDataSource: getIt.call()));

  // DataSource
  getIt.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(auth: getIt.call(), firestore: getIt.call()));
  getIt.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(
            auth: getIt.call(),
            firestore: getIt.call(),
            storage: getIt.call(),
          ));

  // Firebase
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseStorage.instance);
}
