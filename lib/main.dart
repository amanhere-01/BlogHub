
import 'package:blog_hub/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_hub/core/theme/theme.dart';
import 'package:blog_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_hub/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_hub/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_hub/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_hub/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();     // Dependency Injection
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<BlogBloc>(),
        ),
      ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (AppUserState state) {
          return state is AppUserLoggedIn;
        },
        builder: (BuildContext context, bool isLoggedIn) {
          if(isLoggedIn){
            return const BlogPage();
          }
          return const SignInPage();
        },
      )
    );
  }
}