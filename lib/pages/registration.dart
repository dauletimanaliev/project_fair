import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_fair/custom_widgets/custom_buttons.dart';
import 'package:project_fair/pages/gamepage.dart';
import 'package:project_fair/pages/rankings.dart';
import 'package:project_fair/pages/settings.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final globalKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();

  void startgame() {
    if (globalKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Gamepage(
            username: username.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(129, 255, 255, 255),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Go Skiing',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.sp),
                  child: Form(
                    key: globalKey,
                    child: TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Player name',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                CustomButtons(
                  nameButton: 'Start Game',
                  tap: startgame,
                ),
                SizedBox(height: 15.h),
                CustomButtons(
                  nameButton: 'Rankings',
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Rankings()));
                  },
                ),
                SizedBox(height: 15.h),
                CustomButtons(
                  nameButton: 'Settings',
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
