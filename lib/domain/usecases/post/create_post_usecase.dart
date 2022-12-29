import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/repositories/post_repository.dart';

class CreatePostUsecase {
  final PostRepository repository;

  CreatePostUsecase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.createPost(post);
  }
}
