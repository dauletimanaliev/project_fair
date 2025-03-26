import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_fair/pages/registration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SkiingApp());
}

class SkiingApp extends StatefulWidget {
  const SkiingApp({super.key});

  @override
  State<SkiingApp> createState() => _SkiingAppState();
}

class _SkiingAppState extends State<SkiingApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: Size(490, 690),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Registration(),
        );
      },
    );
  }
}
