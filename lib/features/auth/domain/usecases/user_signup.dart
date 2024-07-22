import 'package:blog_hub/core/error/failures.dart';
import 'package:blog_hub/core/usecase/usecase.dart';
import 'package:blog_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';

class UserSignUp implements UseCase<User,UserSignUpParams>{
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>>  call(UserSignUpParams params) async {
    return await authRepository.signUp(
        name: params.name,
        email: params.email,
        password: params.password
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({required this.name, required this.email, required this.password});
}