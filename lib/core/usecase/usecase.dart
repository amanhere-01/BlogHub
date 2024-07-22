import 'package:blog_hub/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<successType, Parameters> {
  Future<Either<Failure,successType>> call(Parameters params);
}

class NoParameters{}