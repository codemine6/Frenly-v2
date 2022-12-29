import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final Timestamp? joinAt;
  final String? username;
  final String? password;
  final String? profileImage;

  const UserEntity({
    this.id,
    this.email,
    this.joinAt,
    this.username,
    this.password,
    this.profileImage,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        joinAt,
        username,
        password,
        profileImage,
      ];
}
