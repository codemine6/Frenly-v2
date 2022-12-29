import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController usernameController = TextEditingController();
  late File image;

  @override
  void initState() {
    final auth = context.read<AuthCubit>().state as Authenticated;
    usernameController.text = auth.user.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            onPressed: () {
              print('save');
            },
            icon: const Icon(CommunityMaterialIcons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(auth.user.profileImage!),
                  radius: 55,
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  child: InkWell(
                    onTap: () {
                      print('Clicken');
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        CommunityMaterialIcons.camera_plus_outline,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: usernameController,
            ),
          ],
        ),
      ),
    );
  }
}
