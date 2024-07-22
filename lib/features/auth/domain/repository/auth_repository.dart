import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/error/failures.dart';

abstract interface class AuthRepository{

  Future<Either<Failure,User>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure,User>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure,User>> currentUser();
}