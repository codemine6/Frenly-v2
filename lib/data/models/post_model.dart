import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  final String? id;
  final bool? archived;
  final String? authorId;
  final String? authorImage;
  final String? authorName;
  final Timestamp? createdAt;
  final String? description;
  final List? images;
  final List? likes;

  const PostModel({
    this.id,
    this.archived,
    this.authorId,
    this.authorImage,
    this.authorName,
    this.createdAt,
    this.description,
    this.images,
    this.likes,
  }) : super(
          id: id,
          archived: archived,
          authorId: authorId,
          authorImage: authorImage,
          authorName: authorName,
          createdAt: createdAt,
          description: description,
          images: images,
          likes: likes,
        );

  factory PostModel.fromDocument(
    DocumentSnapshot postSnapshot,
    DocumentSnapshot userSnapshot,
  ) {
    var postData = postSnapshot.data() as Map<String, dynamic>;
    var userData = userSnapshot.data() as Map<String, dynamic>;

    return PostModel(
      id: postSnapshot.id,
      authorName: userData['username'],
      authorImage: userData['profileImage'],
      createdAt: postData['createdAt'],
      description: postData['description'],
      images: postData['images'],
      likes: postData['likes'],
    );
  }

  Map<String, dynamic> toMap() => {
        'archived': archived,
        'authorId': authorId,
        'createdAt': createdAt,
        'description': description,
        'images': images,
        'likes': likes,
      };
}
