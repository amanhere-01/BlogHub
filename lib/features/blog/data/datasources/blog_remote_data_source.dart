
import 'dart:io';

import 'package:blog_hub/core/error/failures.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/blog_model.dart';

abstract interface class BlogRemoteDataSource{
  Future<BlogModel> uploadBlog(BlogModel blog );
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource{
  final SupabaseClient supabaseClient ;
  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try{
      final blogData = await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e){
      throw Exception(e.message);
    } catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({required File image, required BlogModel blog}) async{
    try{
      await supabaseClient.storage.from('blogs_images').upload(blog.id, image);
      return supabaseClient.storage.from('blogs_images').getPublicUrl(blog.id);
    } on StorageException catch (e){
      throw Exception(e.message);
    }catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try{
      final allBlogs = await supabaseClient.from('blogs').select('*,profiles(name)');    // Join operation on blogs and profiles table to get name of blog poster
      return allBlogs.map((blog) => BlogModel.fromJson(blog).copyWith(posterName: blog['profiles']['name'])).toList();                   // This allBlogs will give a list so we used map method to iterate over list and converting every item into UserModel
    }  on PostgrestException catch (e){
      throw Exception(e.message);
    } catch(e){
      throw Exception(e.toString());
    }
  }

}

/*
  - We will first call the uploadBlogImage which require 2 params first is File which we will give it when we select our image from device
    and second param is BlogModel which is required for giving uploaded image a name(here we are passing a generated id from UUID package) by which we retrieve a particular image
  - After calling uploadBlogImage method we will get a string which we will assign it to UserModel imageUrl in BlogRepoImpl class
  - After all of this now we will call uploadBlog method by which the data will get stored in corresponding columns

 */