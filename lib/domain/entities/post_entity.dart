import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? id;
  final bool? archived;
  final String? authorId;
  final String? authorImage;
  final String? authorName;
  final Timestamp? createdAt;
  final String? description;
  final List? images;
  final List? likes;

  const PostEntity({
    this.id,
    this.archived,
    this.authorId,
    this.authorImage,
    this.authorName,
    this.createdAt,
    this.description,
    this.images,
    this.likes,
  });

  @override
  List<Object?> get props => [
        id,
        archived,
        authorId,
        authorImage,
        authorName,
        createdAt,
        description,
        images,
        likes,
      ];
}
