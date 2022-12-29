import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/post_entity.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object?> get props => [];
}

class PostsLoaded extends PostState {
  final List<PostEntity> posts;

  const PostsLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class PostCreated extends PostState {
  @override
  List<Object?> get props => [];
}

class PostFailure extends PostState {
  @override
  List<Object?> get props => [];
}
