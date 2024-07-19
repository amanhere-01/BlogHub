import 'package:blog_hub/core/theme/app_pallet.dart';
import 'package:blog_hub/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_hub/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_hub/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

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
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign Up',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.white
              ),
            ),
            const SizedBox(height: 30,),
            AuthField( hint: 'Name', controller: nameController,),
            const SizedBox(height: 20,),
            AuthField( hint: 'Email', controller: emailController,),
            const SizedBox(height: 20,),
            AuthField( hint: 'Password', controller: passwordController,isObscureText: true,),
            const SizedBox(height: 40),
            const AuthGradientButton(buttonText: 'Sing Up',),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
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
                        color: AppPallet.gradient2
                      )
                    )
                  ]
                )
              ),
            )

          ],
        ),
      ),
    );
  }
}
