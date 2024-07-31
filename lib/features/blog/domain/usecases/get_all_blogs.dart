import 'package:blog_hub/core/error/failures.dart';
import 'package:blog_hub/core/usecase/usecase.dart';
import 'package:fpdart/src/either.dart';

import '../entities/blog.dart';
import '../repository/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParameters>{
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParameters params) async {
    return await blogRepository.getAllBlogs();
  }

}