import 'package:flutter/material.dart';

class BlogField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const BlogField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      maxLines: null,
      validator: (value){
        if(value!.isEmpty){
          return '$hint is missing!' ;
        }
        return null;
      },
    );
  }
}
