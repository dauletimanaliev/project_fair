import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtons extends StatefulWidget {
  final String nameButton;
  final VoidCallback tap;
  const CustomButtons({super.key, required this.nameButton, required this.tap});

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class _CustomButtonsState extends State<CustomButtons> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230.w,
      height: 50.h,
      child: ElevatedButton(
        onPressed: widget.tap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 157, 205, 244),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(),
        ),
        child: Text(
          widget.nameButton,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
