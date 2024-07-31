import 'package:blog_hub/core/theme/app_pallet.dart';
import 'package:blog_hub/core/utils/reading_time.dart';
import 'package:blog_hub/features/blog/presentation/pages/view_blog_page.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewBlogPage(blog: blog,)));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                blog.imageUrl,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 8, bottom: 8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:  BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: blog.topics .map((element) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Chip(
                            label: Text(element),
                            color: const WidgetStatePropertyAll(Colors.black),
                            ),
                          )
                        ).toList(),
                      ),
                    ),
                    Text(
                      blog.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'By ${blog.posterName!}',
                          // textAlign: TextAlign.center, // Center the text within the container
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            '${readingTime(blog.content)} min read',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500

                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
