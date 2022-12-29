import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_state.dart';
import 'package:frenly/presentation/screens/home/widgets/drawer_content.dart';
import 'package:frenly/presentation/widgets/post_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<PostCubit>().getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frenly'),
      ),
      body: Column(
        children: [
          BlocBuilder<PostCubit, PostState>(
            builder: (context, state) {
              if (state is PostsLoaded) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemBuilder: (context, index) {
                      return PostItem(post: state.posts[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.posts.length,
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      drawer: const DrawerContent(),
    );
  }
}
