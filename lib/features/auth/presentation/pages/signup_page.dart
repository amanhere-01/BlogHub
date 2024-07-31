import 'package:blog_hub/core/common/widgets/loader.dart';
import 'package:blog_hub/core/theme/app_pallet.dart';
import 'package:blog_hub/core/utils/show_snackabar.dart';
import 'package:blog_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_hub/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_hub/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_hub/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blog/presentation/pages/blog_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                    hint: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
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
                    buttonText: 'Sign Up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignUp(
                            name: nameController.text.trim(),
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
                              builder: (context) => const SignInPage()));
                    },
                    child: RichText(
                        text: TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                          TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppPallet.gradient2))
                        ])),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
