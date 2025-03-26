import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_fair/custom_widgets/custom_buttons.dart';
import 'package:project_fair/pages/gamepage.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _sliderValue = 0;
  final Color currentColor = Colors.redAccent;
  final List paleteColor = [
    const Color.fromARGB(255, 241, 51, 37),
    const Color.fromARGB(255, 190, 52, 42),
    const Color.fromARGB(255, 125, 45, 40),
    const Color.fromARGB(189, 188, 24, 12),
    const Color.fromARGB(255, 187, 18, 6),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/skiing_person.png',
              height: 150.h,
            ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.sp),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.blue,
                  thumbColor: Colors.white,
                ),
                child: Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(
                      () {
                        _sliderValue = value;
                      },
                    );
                  },
                ),
              ),
            ),
            CustomButtons(
                nameButton: 'Done',
                tap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Gamepage()));
                })
          ],
        ),
      ),
    );
  }
}
