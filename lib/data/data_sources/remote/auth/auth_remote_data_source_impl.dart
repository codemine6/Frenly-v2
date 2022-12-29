import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frenly/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:frenly/data/models/user_model.dart';
import 'package:frenly/domain/entities/user_entity.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<UserEntity> getAuthStatus() async {
    final userCollection = firestore.collection('users');

    final user = auth.currentUser;
    final snapshot = await userCollection.doc(user?.uid).get();
    return UserModel.fromDocument(snapshot);
  }

  @override
  Future<UserEntity> signInUser(UserEntity user) async {
    final userCollection = firestore.collection('users');

    final credential = await auth.signInWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    );
    final snapshot = await userCollection.doc(credential.user!.uid).get();
    return UserModel.fromDocument(snapshot);
  }

  @override
  Future<void> signOutUser() async {
    await auth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    final userCollection = firestore.collection('users');

    final credential = await auth.createUserWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    );
    final data = UserModel(
      email: credential.user?.email,
      joinAt: Timestamp.fromDate(credential.user!.metadata.creationTime!),
      username: user.username,
      profileImage: 'https://bit.ly/3v2mbug',
    ).toMap();
    await userCollection.doc(credential.user?.uid).set(data);
  }
}
