import 'package:blog_hub/core/theme/app_pallet.dart';
import 'package:blog_hub/core/utils/format_date.dart';
import 'package:blog_hub/core/utils/reading_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/blog.dart';

class ViewBlogPage extends StatelessWidget {
  final Blog blog;
  const ViewBlogPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'By ${blog.title}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        blog.imageUrl,
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                ),
                const SizedBox(height: 20,),
                Text(
                  'By ${blog.posterName}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${formateDate(blog.updatedAt)} ',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppPallet.greyColor
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        '${readingTime(blog.content)} min read',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppPallet.greyColor
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Text(
                  'By ${blog.content}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemGrey4,
                      height: 2
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
