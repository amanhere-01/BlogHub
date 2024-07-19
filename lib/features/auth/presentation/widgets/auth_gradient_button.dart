import 'package:blog_hub/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  const AuthGradientButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            colors: [
              AppPallet.gradient1,
              AppPallet.gradient2,
              AppPallet.gradient3
            ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
        )
      ),
      child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            fixedSize:  Size(MediaQuery.of(context).size.width, 55),
            backgroundColor: AppPallet.transparentColor,
            shadowColor: AppPallet.transparentColor,
          ),
          child: Text(buttonText,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),
          ),
      ),
    );
  }
}
