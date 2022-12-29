import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/usecases/auth/get_auth_status_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_in_user_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_out_user_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_up_user_usecase.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetAuthStatusUseCase getAuthStatusUseCase;
  final SignInUserUseCase signInUserUseCase;
  final SignOutUserUseCase signOutUserUseCase;
  final SignUpUserUseCase signUpUserUseCase;

  AuthCubit({
    required this.getAuthStatusUseCase,
    required this.signInUserUseCase,
    required this.signOutUserUseCase,
    required this.signUpUserUseCase,
  }) : super(AuthInitial());

  Future<void> getAuthStatus() async {
    try {
      final currentUser = await getAuthStatusUseCase.call();
      emit(Authenticated(user: currentUser));
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> signInUser(UserEntity user) async {
    try {
      final currentUser = await signInUserUseCase.call(user);
      emit(Authenticated(user: currentUser));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? ''));
    }
  }

  Future<void> signOutUser() async {
    try {
      await signOutUserUseCase.call();
      emit(UnAuthenticated());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> signUpUser(UserEntity user) async {
    try {
      await signUpUserUseCase.call(user);
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? ''));
    }
  }
}
