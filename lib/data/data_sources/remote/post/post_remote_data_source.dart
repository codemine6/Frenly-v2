import 'package:frenly/domain/entities/post_entity.dart';

abstract class PostRemoteDataSource {
  Future<void> createPost(PostEntity post);
  Future<List<PostEntity>> getPosts();
  Future<void> likePost(PostEntity post);
}
