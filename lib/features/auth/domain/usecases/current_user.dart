
import 'package:blog_hub/core/error/failures.dart';
import 'package:blog_hub/core/usecase/usecase.dart';
import 'package:blog_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';


class CurrentUser implements UseCase<User,NoParameters> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParameters params) async{
    return await authRepository.currentUser();
  }
}
