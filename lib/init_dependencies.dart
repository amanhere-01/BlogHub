import 'package:blog_hub/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_hub/features/auth/domain/usecases/current_user.dart';
import 'package:blog_hub/features/auth/domain/usecases/user_signin.dart';
import 'package:blog_hub/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_hub/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_hub/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog_hub/features/blog/domain/repository/blog_repository.dart';
import 'package:blog_hub/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_hub/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_hub/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secret/app_secrets.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repository/auth_repository_implementation.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // Data Source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    // since AuthRepositoryImplementation requires AuthRemoteDataSource so we wrote it's generic but if we do not do so then serviceLocator will get confuse as it does not know that AuthRemoteDataSourceImplementation implements AuthRemoteDataSource
    // Also AuthRemoteDataSourceImplementation requires supabase client so we registered it above already
    () => AuthRemoteDataSourceImplementation(serviceLocator()),
  );

  // Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImplementation(serviceLocator()),
  );

  // Use Cases
  serviceLocator.registerFactory(
    () => UserSignUp(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserSignIn(serviceLocator()),
  );
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  // Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator()),
  );
}

void _initBlog() {
  // Data Source
  serviceLocator..registerFactory<BlogRemoteDataSource>(
          () => BlogRemoteDataSourceImpl(serviceLocator())
  )
  // Repository
  ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator())
  )
  // Use Cases
  ..registerFactory(
      () => UploadBlog(serviceLocator())
  )
  ..registerFactory(
      () => GetAllBlogs(serviceLocator())
  )
  // Bloc
  ..registerLazySingleton(
      () => BlogBloc(
          uploadBlog: serviceLocator(),
          getAllBlogs: serviceLocator()
      )
  )

  ;
}
