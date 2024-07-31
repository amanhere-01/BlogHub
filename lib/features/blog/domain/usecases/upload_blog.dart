import 'dart:io';
import 'package:blog_hub/core/error/failures.dart';
import 'package:blog_hub/core/usecase/usecase.dart';
import 'package:blog_hub/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

import '../entities/blog.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics);
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  UploadBlogParams(
      {required this.image,
      required this.title,
      required this.content,
      required this.posterId,
      required this.topics});
}
