import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_fair/pages/rankings.dart';

class Gamepage extends StatefulWidget {
  final String? username;
  const Gamepage({super.key, this.username});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  double treesX1 = 0;
  double treesX2 = 0;
  double treesWidth = 0;
  double speedX = 6.w;

  double skierY = 77.h;
  double jumpHeight = 120.h;
  bool isJumping = false;
  double gravity = 4.h;

  int gameTime = 0;
  int coins = 0;

  double coinX = 500.w;
  double coinY = 77.h;

  double obstacleX = 600.w; // obstacles
  double obstacleY = 77.h;
  bool gameOver = false; // flag for ending game

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!gameOver) {
        setState(() {
          gameTime++;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        treesWidth = MediaQuery.of(context).size.width;
        treesX2 = treesWidth;
      });

      Timer.periodic(Duration(milliseconds: 20), (timer) {
        if (!gameOver) {
          setState(() {
            treesX1 -= speedX;
            treesX2 -= speedX;
            coinX -= speedX;
            obstacleX -= speedX; // obstacles to the left 

            if (treesX1 <= -treesWidth) {
              treesX1 = treesX2 + treesWidth;
            }
            if (treesX2 <= -treesWidth) {
              treesX2 = treesX1 + treesWidth;
            }

            if (isJumping) {
              skierY += gravity;
              if (skierY >= 77.h + jumpHeight) {
                isJumping = false;
              }
            } else if (skierY > 77.h) {
              skierY -= gravity;
              if (skierY < 77.h) skierY = 77.h;
            }

            if ((coinX - (MediaQuery.of(context).size.width / 2 - 60.w)).abs() <
                    40.w &&
                (coinY - skierY).abs() < 40.h) {
              coins++;
              generateNewCoin();
            }

            if (coinX < -50.w) {
              generateNewCoin();
            }

            // obstacle collision check
            if ((obstacleX - (MediaQuery.of(context).size.width / 2 - 60.w))
                        .abs() <
                    50.w &&
                (obstacleY - skierY).abs() < 40.h &&
                !isJumping) {
              gameOver = true; // game over
              showGameOverDialog();
            }

            if (obstacleX < -50.w) {
              generateNewObstacle();
            }
          });
        }
      });
    });
  }

  void jump() {
    if (!gameOver && skierY == 77.h) {
      setState(() {
        isJumping = true;
      });
    }
  }

  void generateNewCoin() {
    Random random = Random();
    double newCoinX;

    do {
      newCoinX = MediaQuery.of(context).size.width + random.nextInt(300).w;
    } while ((newCoinX - obstacleX).abs() < 250.w); // checkpoint for distance

    setState(() {
      coinX = newCoinX;
      coinY = 77.h + random.nextInt(80).h;
    });
  }

  double lastObstacleX = 0; // final
  double minObstacleDistance =
      200.w; // min distance between obstacles

 void generateNewObstacle() {
  Random random = Random();
  
  //  obstacles are always at least 400.w apart
  double newObstacleX = lastObstacleX + minObstacleDistance + 400.w + random.nextInt(300).w;

  setState(() {
    obstacleX = newObstacleX;
    obstacleY = 77.h;
    lastObstacleX = newObstacleX; //  last obstacle position
  });
}
  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Player name: ${widget.username}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/coin.png',
                  width: 30.w,
                ),
                SizedBox(width: 5.w),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '$coins',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Time: ${gameTime}s',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: Text("Restart",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Rankings()));
            },
            child: Text(
              "Go To Rankings",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      skierY = 77.h;
      isJumping = false;
      gameTime = 0;
      coins = 0;
      gameOver = false;
      coinX = 500.w;
      obstacleX = 600.w;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: jump,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg.jpg',
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
                left: treesX1, bottom: 0, child: treesWidget(screenWidth)),
            Positioned(
                left: treesX2, bottom: 0, child: treesWidget(screenWidth)),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),

            Positioned(
              bottom: skierY,
              left: screenWidth / 2 - 100.w,
              child: Image.asset(
                'assets/images/skiing_person.png',
                width: 120.w,
              ),
            ),

            Positioned(
              bottom: coinY,
              left: coinX,
              child: Image.asset(
                'assets/images/coin.png',
                width: 40.w,
              ),
            ),

            // obstacle
            Positioned(
              bottom: obstacleY,
              left: obstacleX,
              child: Image.asset(
                'assets/images/obstacle.png',
                width: 50.w,
              ),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.pause,
                      size: 40.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.username.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/coin.png',
                              width: 30.w,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              '$coins',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '$gameTime s',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget treesWidget(double width) {
    return Image.asset(
      'assets/images/trees.png',
      width: 900.w,
      fit: BoxFit.cover,
    );
  }
}
