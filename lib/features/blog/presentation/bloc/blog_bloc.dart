import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_hub/core/usecase/usecase.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/blog.dart';
import '../../domain/usecases/get_all_blogs.dart';
import '../../domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllBlogs>(_onGetAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics));
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onGetAllBlogs(BlogGetAllBlogs event, Emitter<BlogState> emit) async{
    final res = await _getAllBlogs.call(NoParameters());
    res.fold(
          (l) => emit(BlogFailure(l.message)),
          (r) => emit(BlogDisplaySuccess(r)),
    );
  }
}
