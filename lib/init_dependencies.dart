
import 'package:blog_hub/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_hub/features/auth/domain/usecases/current_user.dart';
import 'package:blog_hub/features/auth/domain/usecases/user_signin.dart';
import 'package:blog_hub/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secret/app_secrets.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/auth_supabase_data_source.dart';
import 'features/auth/data/repository/auth_repository_implementation.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async{
  _initAuth();
  final supabase= await Supabase.initialize(
      url: AppSecrets.supabaseUrl,
      anonKey: AppSecrets.supabaseAnonKey
  );
  serviceLocator.registerLazySingleton(
      () => supabase.client
  );

  //core
  serviceLocator.registerLazySingleton(
      () => AppUserCubit()
  );
}

void _initAuth(){

  // Data Source
  serviceLocator.registerFactory<AuthSupabaseDataSource>( // since AuthRepositoryImplementation requires AuthSupabaseDataSource so we wrote it's generic but if we do not do so then serviceLocator will get confuse as it does not that AuthSupabaseDataSourceImplementation implements AuthSupabaseDataSource
          () => AuthSupabaseDataSourceImplementation(
              serviceLocator()
          ),
  );

  // Repository
  serviceLocator.registerFactory<AuthRepository>(
          () => AuthRepositoryImplementation(
              serviceLocator()
          ),
  );

  // Use Cases
  serviceLocator.registerFactory(
          () => UserSignUp(
              serviceLocator()
          ),
  );
  serviceLocator.registerFactory(
        () => UserSignIn(
        serviceLocator()
        ),
  );
  serviceLocator.registerFactory(
      () => CurrentUser(serviceLocator())
  );

  // Bloc
  serviceLocator.registerLazySingleton(
          () => AuthBloc(
              userSignUp: serviceLocator(),
              userSignIn: serviceLocator(),
              currentUser: serviceLocator(),
              appUserCubit: serviceLocator()
          ),
  );

}