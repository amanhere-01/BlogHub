
import 'package:blog_hub/core/utils/show_snackabar.dart';
import 'package:blog_hub/features/blog/presentation/pages/new_blog_page.dart';
import 'package:blog_hub/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/theme/app_pallet.dart';
import '../bloc/blog_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Hub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, NewBlogPage.route());
              },
              icon: const Icon(Icons.add_circle_outline)
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state){
          if(state is BlogFailure){
            return showSnackbar(context, state.message);
          }
        },
        builder: (context, state){
          if(state is BlogLoading){
            return const Loader();
          }
          if(state is BlogDisplaySuccess){
            return ListView.builder(
                itemCount: state.blogs.length ,
                itemBuilder: (context, index){
                  final blog = state.blogs[state.blogs.length-index-1];
                  return BlogCard(
                      blog: blog ,
                      color: index%3==0 ? AppPallet.gradient1.withOpacity(0.5) : index%3==1 ? AppPallet.gradient2.withOpacity(0.5) : AppPallet.gradient3.withOpacity(0.5),
                  );
                }
            );
          }
         return const SizedBox();
        },
      ),
    );
  }
}
