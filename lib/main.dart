import 'package:blog_hub/core/theme/theme.dart';
import 'package:blog_hub/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const SignInPage(),
    );
  }
}