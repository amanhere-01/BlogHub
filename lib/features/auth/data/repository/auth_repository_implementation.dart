import 'package:blog_hub/core/error/failures.dart';
import 'package:blog_hub/core/network/connection_checker.dart';
import 'package:blog_hub/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_hub/features/auth/data/models/user_model.dart';
import 'package:fpdart/src/either.dart';
import '../../../../core/common/entities/user.dart';
import '../../domain/repository/auth_repository.dart';


class AuthRepositoryImplementation implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImplementation(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try{
      if(! await connectionChecker.isConnected){
        final session = remoteDataSource.currentSession;
        if(session==null){
          return left(Failure('User is not logged in!'));
        }
        return right(UserModel(id: session.user.id, name: '', email: session.user.email ?? ''));
      }
      final user = await remoteDataSource.currentUserData();
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
      if(! await connectionChecker.isConnected){
        return left(Failure('No Internet Connection!'));
      }
      final user = await remoteDataSource.signIn(
          email: email,
          password: password
      );
      return right(user);
    } catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({required String name, required String email, required String password}) async{
    try{
      if(! await connectionChecker.isConnected){
        return left(Failure('No Internet Connection!'));
      }
      final user = await remoteDataSource.signUp(
        name: name,
        email: email,
        password: password
      );
      return right(user);
    } catch(e){
      return left(Failure(e.toString()));
    }
  }




}