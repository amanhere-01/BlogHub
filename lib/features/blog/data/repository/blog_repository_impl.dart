import 'dart:io';

import 'package:blog_hub/core/error/failures.dart';
import 'package:blog_hub/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_hub/features/blog/data/models/blog_model.dart';
import 'package:blog_hub/features/blog/domain/entities/blog.dart';
import 'package:blog_hub/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics
  }) async {
    try{
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),      // It will generate time based id for blog images and blogs database table
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          updatedAt: DateTime.now()
      );
      // now we first call uploadBlogImage then assign the returned string to imageUrl and for that we have to create BlogModel copyWith function in UserModel as we need to update the imageUrl of blogModel
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(image: image, blog: blogModel);
      final updatedBlogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(updatedBlogModel);
      return right(uploadedBlog);
    } on Exception catch(e){
      return left(Failure(e.toString()));
    }

  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async{
    try{
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on Exception catch(e){
      return left(Failure(e.toString()));
    }
  }
}
