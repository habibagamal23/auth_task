import 'package:flutter/material.dart';

class ColorManager {
  static const Color white = Color(0xFFFFFFFF);
  static const Color grayLight = Color(0xFFE9E9E8);
  static Color darkgreen = const Color(0xFF395A64);
  static const Color black = Color(0xFF000000);
  static const Color darkBlue = Color(0xFF061C57);
  static const lightGrey = Color(0xFFACB4CC);
}

class AssetManager {
  static const String loginOrRigister = "assets/loginOrSignupImage.png";
}

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title:Text("Please Wait"),
          content: SizedBox(
              height: 50, child: Center(child: CircularProgressIndicator())),
        );
      });
}