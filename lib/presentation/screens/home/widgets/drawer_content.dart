import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(auth.user.profileImage!),
                  radius: 40,
                ),
                const SizedBox(
                  height: 18,
                ),
                Text('${auth.user.username}'),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(CommunityMaterialIcons.cog_outline),
            title: const Text('Settings'),
            onTap: () {
              context.push('/settings');
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                context.go('/sign_in');
              }
            },
            child: ListTile(
              leading: const Icon(CommunityMaterialIcons.logout_variant),
              title: const Text('Logout'),
              onTap: () {
                context.read<AuthCubit>().signOutUser();
              },
            ),
          ),
        ],
      ),
    );
  }
}
