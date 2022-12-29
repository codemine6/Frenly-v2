import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:frenly/injection_container.dart' as di;
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/screens/auth/sign_in_screen.dart';
import 'package:frenly/presentation/screens/auth/sign_up_screen.dart';
import 'package:frenly/presentation/screens/home/home_screen.dart';
import 'package:frenly/presentation/screens/post/create_post_screen.dart';
import 'package:frenly/presentation/screens/settings/settings_screen.dart';
import 'package:frenly/presentation/screens/user/edit_profile_screen.dart';
import 'package:frenly/presentation/screens/user/profile_screen.dart';
import 'package:frenly/presentation/widgets/custom_bottom_bar.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.getIt<AuthCubit>()..getAuthStatus(),
        ),
        BlocProvider(
          create: (context) => di.getIt<PostCubit>(),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          print('Screen rebuild');
          if (state is AuthInitial) {
            return const SizedBox();
          } else {
            return MaterialApp.router(
              routerConfig: GoRouter(
                routes: _routes,
                initialLocation: state is Authenticated ? '/' : '/sign_in',
              ),
              debugShowCheckedModeBanner: false,
            );
          }
        },
        listener: (context, state) {
          FlutterNativeSplash.remove();
        },
        buildWhen: (previous, current) {
          if (current is AuthFailure) return false;
          return true;
        },
      ),
    );
  }
}

final _routes = [
  ShellRoute(
    builder: (context, state, child) {
      return Scaffold(
        body: child,
        bottomNavigationBar: const CustomBottomBar(),
      );
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/create_post',
        builder: (context, state) => const CreatePostScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  ),
  GoRoute(
    path: '/edit_profile',
    builder: (context, state) => const EditProfileScreen(),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsScreen(),
  ),
  GoRoute(
    path: '/sign_in',
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    path: '/sign_up',
    builder: (context, state) => const SignUpScreen(),
  ),
];
