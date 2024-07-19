import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isObscureText;
  const AuthField({
    super.key,
    required this.hint,
    required this.controller,
    this.isObscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text(hint,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
          ),
          const SizedBox(height: 8,),
          TextFormField(
            controller: controller,
            validator: (value){
              if(value!.isEmpty){
                return '$hint is empty';
              }
              return null;
            },
            obscureText: isObscureText,
          ),
        ],
      ),
    );
  }
}
