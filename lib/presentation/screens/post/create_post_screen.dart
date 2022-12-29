import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_state.dart';
import 'package:frenly/presentation/screens/post/widgets/image_list.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController descriptionController = TextEditingController();
  List<File> imageList = [];

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 512,
        maxHeight: 384,
      );
      if (image != null) {
        setState(() {
          imageList = [...imageList, File(image.path)];
        });
      }
    } catch (_) {}
  }

  Future _pickMultiImage() async {
    try {
      final images = await ImagePicker().pickMultiImage(
        maxWidth: 512,
        maxHeight: 384,
      );
      final aaa = images.map((e) => File(e.path)).toList();
      setState(() {
        imageList = [...imageList, ...aaa];
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          BlocListener<PostCubit, PostState>(
            listener: (context, state) {
              if (state is PostCreated) {
                context.go('/');
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<PostCubit>().createPost(PostEntity(
                      authorId: auth.user.id,
                      description: descriptionController.text,
                      images: imageList,
                    ));
              },
              icon: const Icon(CommunityMaterialIcons.send_outline),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('New Post'),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(
              height: 16,
            ),
            ImageList(
              imageList: imageList,
              pickImage: _pickImage,
              pickMultiImage: _pickMultiImage,
              removeImage: (image) {
                setState(() {
                  imageList.remove(image);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
