import 'package:blog_hub/core/error/failures.dart';
import 'package:blog_hub/core/usecase/usecase.dart';
import 'package:blog_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignIn(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.signIn(
        email: params.email,
        password: params.password
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
