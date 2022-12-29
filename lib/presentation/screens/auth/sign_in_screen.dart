import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureTextPassword = true;

  @override
  void initState() {
    emailController.text = 'jonathan@mail.com';
    passwordController.text = 'qwerty';
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Text(
                'Welcome back.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  prefixIcon: Icon(CommunityMaterialIcons.email_outline),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                  prefixIcon: const Icon(CommunityMaterialIcons.lock_outline),
                  suffixIcon: GestureDetector(
                    child: Icon(obscureTextPassword
                        ? CommunityMaterialIcons.eye_outline
                        : CommunityMaterialIcons.eye_off_outline),
                    onTap: () {
                      setState(() {
                        obscureTextPassword = !obscureTextPassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: obscureTextPassword,
              ),
              const SizedBox(
                height: 48,
              ),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    print('State : $state');
                    // context.read<AuthCubit>().getCurrentUser();
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().signInUser(UserEntity(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () => context.go('/sign_up'),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
