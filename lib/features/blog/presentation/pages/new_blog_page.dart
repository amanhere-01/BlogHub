import 'dart:io';

import 'package:blog_hub/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_hub/core/common/widgets/loader.dart';
import 'package:blog_hub/core/constants/constants.dart';
import 'package:blog_hub/core/theme/app_pallet.dart';
import 'package:blog_hub/core/utils/pick_image.dart';
import 'package:blog_hub/core/utils/show_snackabar.dart';
import 'package:blog_hub/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_hub/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_hub/features/blog/presentation/widgets/blog_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const NewBlogPage());
  const NewBlogPage({super.key});

  @override
  State<NewBlogPage> createState() => _NewBlogPageState();
}

class _NewBlogPageState extends State<NewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(BlogUpload(
          image: image!,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          posterId: posterId,
          topics: selectedTopics));
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: uploadBlog, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if(state is BlogFailure){
            showSnackbar(context, state.message);
          }
          else if(state is BlogUploadSuccess){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const BlogPage()), (route) => false);
          }
        },
        builder: (context, state) {
          if(state is BlogLoading){
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                                height: 250,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                                color: AppPallet.borderColor,
                                radius: const Radius.circular(20),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                dashPattern: const [10, 4],
                                child: const SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 50,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Select your image',
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:Constants.topicsList
                            .map((element) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectedTopics.contains(element)) {
                                        selectedTopics.remove(element);
                                      } else {
                                        selectedTopics.add(element);
                                      }
                                      setState(() {});
                                    },
                                    child: Chip(
                                      label: Text(element),
                                      color: selectedTopics.contains(element)
                                          ? const WidgetStatePropertyAll(
                                              AppPallet.gradient3)
                                          : null,
                                      side: selectedTopics.contains(element)
                                          ? null
                                          : const BorderSide(
                                              color: AppPallet.borderColor),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlogField(controller: titleController, hint: 'Blog Title'),
                    const SizedBox(
                      height: 20,
                    ),
                    BlogField(
                        controller: contentController, hint: 'Blog Content')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
