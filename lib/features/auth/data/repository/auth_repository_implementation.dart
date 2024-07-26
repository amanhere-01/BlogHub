import 'package:blog_hub/core/error/failures.dart';
import 'package:blog_hub/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../../core/common/entities/user.dart';
import '../../domain/repository/auth_repository.dart';


class AuthRepositoryImplementation implements AuthRepository{
  final AuthRemoteDataSource supabaseDataSource;
  const AuthRepositoryImplementation(this.supabaseDataSource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try{
      final user = await supabaseDataSource.currentUserData();
      if(user == null){
        return left(Failure('User is not logged in!'));
      }
      return right(user);
    } catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signIn({required String email, required String password}) async {
    try{
      final user = await supabaseDataSource.signIn(
          email: email,
          password: password
      );
      return right(user);
    } on sb.AuthException catch(e){       // as User class is in Supabase and in my project too so as we import supabase then we have to use it using prefix
      return left(Failure(e.toString()));
    } catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({required String name, required String email, required String password}) async{
    try{
      final user = await supabaseDataSource.signUp(
        name: name,
        email: email,
        password: password
      );
      return right(user);
    } on sb.AuthException catch(e){
      return left(Failure(e.toString()));
    } catch(e){
      return left(Failure(e.toString()));
    }
  }



}