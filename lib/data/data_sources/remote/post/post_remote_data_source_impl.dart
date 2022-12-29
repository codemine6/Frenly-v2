import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/data_sources/remote/post/post_remote_data_source.dart';
import 'package:frenly/data/models/post_model.dart';
import 'package:frenly/domain/entities/post_entity.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  PostRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> createPost(PostEntity post) async {
    final postCollection = firestore.collection('posts');

    final urls = post.images?.map((image) async {
      try {
        final name = image.path.split('/').last;
        final storageRef = storage.ref('posts').child(name);
        await storageRef.putFile(image);
        return await storageRef.getDownloadURL();
      } catch (_) {}
    }).toList();
    final images = await Future.wait(urls!);

    final data = PostModel(
      archived: false,
      authorId: post.authorId,
      createdAt: Timestamp.now(),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      images: images,
      likes: const [],
    ).toMap();
    postCollection.add(data);
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    final postCollection = firestore.collection('posts');
    final userCollection = firestore.collection('users');

    final postsSnapshot = await postCollection.get();
    final posts = postsSnapshot.docs.map((document) async {
      final userSnapshot =
          await userCollection.doc(document.data()['authorId']).get();
      return PostModel.fromDocument(document, userSnapshot);
    }).toList();
    return Future.wait(posts);
  }

  @override
  Future<void> likePost(PostEntity post) async {
    final postCollection = firestore.collection('posts');
    final userId = auth.currentUser!.uid;

    final snapshot = await postCollection.doc(post.id).get();
    final List likes = snapshot['likes'];
    if (likes.contains(userId)) {
      postCollection.doc(post.id).update({
        'likes': FieldValue.arrayRemove([userId])
      });
    } else {
      postCollection.doc(post.id).update({
        'likes': FieldValue.arrayUnion([userId])
      });
    }
  }
}
