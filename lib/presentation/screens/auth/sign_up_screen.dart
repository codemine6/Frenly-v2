import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;

@override
  void initState() {
    usernameController.text = 'Jonathan Smith';
    emailController.text = 'jonathan@mail.com';
    passwordController.text = 'qwerty';
    super.initState();
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
                'Create account.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  prefixIcon: Icon(CommunityMaterialIcons.email_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 24,
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
                height: 24,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                  prefixIcon: const Icon(CommunityMaterialIcons.lock_outline),
                  suffixIcon: GestureDetector(
                    child: Icon(obscureTextConfirmPassword
                        ? CommunityMaterialIcons.eye_outline
                        : CommunityMaterialIcons.eye_off_outline),
                    onTap: () {
                      setState(() {
                        obscureTextConfirmPassword =
                            !obscureTextConfirmPassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: obscureTextConfirmPassword,
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                    ));
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().signUpUser(UserEntity(
                          email: emailController.text,
                          username: usernameController.text,
                          password: passwordController.text,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text(
                    'Sign Up',
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
                  const Text('Already have account?'),
                  TextButton(
                    onPressed: () => context.go('/sign_in'),
                    child: const Text('Sign In'),
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
