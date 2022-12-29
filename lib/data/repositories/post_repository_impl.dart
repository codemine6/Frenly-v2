import 'package:frenly/data/data_sources/remote/post/post_remote_data_source.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createPost(PostEntity post) {
    return remoteDataSource.createPost(post);
  }

  @override
  Future<List<PostEntity>> getPosts() {
    return remoteDataSource.getPosts();
  }

  @override
  Future<void> likePost(PostEntity post) {
    return remoteDataSource.likePost(post);
  }
}
