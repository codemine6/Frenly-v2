import 'package:community_material_icon/community_material_icon.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';

class PostItem extends StatefulWidget {
  final PostEntity post;

  const PostItem({super.key, required this.post});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool liked = false;
  int totalLikes = 0;

  @override
  void initState() {
    final auth = context.read<AuthCubit>().state as Authenticated;
    if (widget.post.likes!.contains(auth.user.id)) {
      setState(() {
        liked = true;
      });
    }
    setState(() {
      totalLikes = widget.post.likes!.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.post.authorImage!),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                children: [
                  Text(
                    '${widget.post.authorName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    formatDate(
                      widget.post.createdAt!.toDate(),
                      [dd, ' ', MM, ' ', yyyy],
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text('${widget.post.description}'),
          const SizedBox(
            height: 12,
          ),
          if (widget.post.images != null && widget.post.images!.isNotEmpty)
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                widget.post.images![0],
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              InkWell(
                child: Icon(
                  liked
                      ? CommunityMaterialIcons.heart
                      : CommunityMaterialIcons.heart_outline,
                ),
                onTap: () {
                  context
                      .read<PostCubit>()
                      .likePost(PostEntity(id: widget.post.id));
                  if (liked) {
                    setState(() {
                      liked = false;
                      totalLikes -= 1;
                    });
                  } else {
                    setState(() {
                      liked = true;
                      totalLikes += 1;
                    });
                  }
                },
              ),
              const SizedBox(
                width: 4,
              ),
              if (totalLikes > 0)
                Text(
                  '$totalLikes',
                  style: TextStyle(fontSize: 12),
                ),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                child: const Icon(
                  CommunityMaterialIcons.comment_outline,
                ),
                onTap: () {
                  print('Cooment this post');
                },
              ),
              const SizedBox(
                width: 4,
              ),
              const Text(
                '98',
                style: TextStyle(fontSize: 12),
              ),
              const Spacer(),
              InkWell(
                child: const Icon(
                  CommunityMaterialIcons.send_outline,
                ),
                onTap: () {
                  print('Send this post');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
