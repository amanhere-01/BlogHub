import 'package:blog_hub/core/theme/app_pallet.dart';
import 'package:blog_hub/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_hub/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_hub/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

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
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign In',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white
              ),
            ),
            const SizedBox(height: 30,),
            AuthField( hint: 'Email', controller: emailController,),
            const SizedBox(height: 20,),
            AuthField( hint: 'Password', controller: passwordController,isObscureText: true,),
            const SizedBox(height: 40),
            const AuthGradientButton(buttonText: 'Sign In',),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
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
