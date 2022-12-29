import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/usecases/post/create_post_usecase.dart';
import 'package:frenly/domain/usecases/post/get_posts_usecase.dart';
import 'package:frenly/domain/usecases/post/like_post_usecase.dart';
import 'package:frenly/presentation/cubit/post/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUsecase createPostUsecase;
  final GetPostsUseCase getPostsUseCase;
  final LikePostUseCase likePostUseCase;

  PostCubit({
    required this.createPostUsecase,
    required this.getPostsUseCase,
    required this.likePostUseCase,
  }) : super(PostInitial());

  Future<void> createPost(PostEntity post) async {
    try {
      await createPostUsecase.call(post);
      emit(PostCreated());
    } catch (e) {
      print(e);
      emit(PostFailure());
    }
  }

  Future<void> getPosts() async {
    try {
      final posts = await getPostsUseCase.call();
      emit(PostsLoaded(posts: posts));
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> likePost(PostEntity post) async {
    try {
      await likePostUseCase.call(post);
    } catch (e) {
      emit(PostFailure());
      print('Errorrr : $e');
    }
  }
}
