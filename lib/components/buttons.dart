import 'package:flutter/material.dart';

import '../constants.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const BlueButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 12,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(ColorManager.darkBlue),
          backgroundColor: MaterialStateProperty.all(ColorManager.darkBlue),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: ColorManager.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class GrayButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GrayButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 12,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(ColorManager.grayLight),
          backgroundColor: MaterialStateProperty.all(ColorManager.grayLight),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: ColorManager.lightGrey,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
