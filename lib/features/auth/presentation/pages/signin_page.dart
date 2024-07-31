import 'package:blog_hub/core/theme/app_pallet.dart';
import 'package:blog_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_hub/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_hub/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_hub/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog_hub/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/utils/show_snackabar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthFailure){
            showSnackbar(context, state.message);
          } else if(state is AuthSuccess){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BlogPage()), (route) => false);
          }
        },
        builder: (context, state) {
          if(state is AuthLoading){
            return const Loader();
          }
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthField(
                  hint: 'Email',
                  controller: emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthField(
                  hint: 'Password',
                  controller: passwordController,
                  isObscureText: true,
                ),
                const SizedBox(height: 40),
                AuthGradientButton(
                  buttonText: 'Sign In',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(AuthSignIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim()));
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: const [
                        TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppPallet.gradient2))
                      ])),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
