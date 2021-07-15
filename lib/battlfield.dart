import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/barrier.dart';
import 'package:game/bird.dart';
import 'package:game/constant.dart';
import 'package:game/heightBarrier.dart';

bool gameFail = false;

double time = 0;
double height = 0;
double initalHeight = birdY;
double temp = -15;

double posFirstXBarrier = widthScreen+100;
double posSecondXBarrier = posFirstXBarrier + widthScreen/2;
double posThirdXBarrier = posSecondXBarrier + widthScreen/2;

class battlfield extends StatefulWidget {
  _mainBattlfield createState() => _mainBattlfield();
}

class _mainBattlfield extends State<battlfield> {
  static double firstHeightUp = values.getUp();
  static double firstHeightDown = values.getDown(firstHeightUp);

  static double secondHeightUp = values.getUp();
  static double secondHeightDown = values.getDown(secondHeightUp);

  static double thirdHeightUp = values.getUp();
  static double thirdHeightDown = values.getDown(thirdHeightUp);

  @override
  Widget build(BuildContext context) {
    if (!initStartBirdXY) {
      birdX = MediaQuery.of(context).size.width / 2.3;
      birdY = MediaQuery.of(context).size.height / 2.66;
      widthScreen = birdX * 2;
      heightScreen = (MediaQuery.of(context).size.height / 2.66) * 2.0;
      initStartBirdXY = true;
    }
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        if (gameIsStart) {
          flyBird();
        } else {
          flyBird();
          moveBarrier();
          startGame();
        }
      },
      child: Column(children: [
        Expanded(
          flex: 10,
          child: Container(
            color: Colors.blue,
            child: Stack(
              children: [
                Positioned(child: bird(), left: birdX, bottom: birdY),
                Container(
                    alignment: Alignment(0, -0.3),
                    child: gameIsStart
                        ? Text("")
                        : Text(
                            print1,
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          )),
                Positioned(
                    left: posFirstXBarrier,
                    top: temp,
                    child: barrier(
                      height: firstHeightUp,
                    )),
                Positioned(
                    left: posFirstXBarrier,
                    bottom: temp,
                    child: barrier(
                      height: firstHeightDown,
                    )),
                Positioned(
                    left: posSecondXBarrier,
                    top: temp,
                    child: barrier(
                      height: secondHeightUp,
                    )),
                Positioned(
                    left: posSecondXBarrier,
                    bottom: temp,
                    child: barrier(
                      height: secondHeightDown,
                    )),
                Positioned(
                    left: posThirdXBarrier,
                    top: temp,
                    child: barrier(
                      height: thirdHeightUp,
                    )),
                Positioned(
                    left: posThirdXBarrier,
                    bottom: temp,
                    child: barrier(
                      height: thirdHeightDown,
                    )),
              ],
            ),
          ),
        ),
        Container(
          height: 20,
          color: Colors.green,
        ),
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Score",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text(
                        "$score",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Best",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text(
                        "${bestScore.toString()}",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ],
                  )
                ],
              ),
            ))
      ]),
    ));
  }

  void flyBird() {
    setState(() {
      time = -8;
      initalHeight = birdY;
    });
  }

  void startGame() {
    gameIsStart = true;
    Timer.periodic(Duration(milliseconds: 15), (timer) {
      time += 0.18;
      height = 4.9 * time * time + 40 * time;
      setState(() {
        birdY = initalHeight - height;
      });
      if (birdY < -20 || gameFail) {
        birdY = 276;
        posFirstXBarrier = widthScreen + 80;
        posSecondXBarrier = posFirstXBarrier + widthScreen / 2;
        posThirdXBarrier = posSecondXBarrier + widthScreen / 2;
        showResultGame();
        initStartBirdXY = false;
        if (score > bestScore) bestScore = score;
        height = 0;
        initalHeight = birdY;
        time = 0;
        gameIsStart = false;
        gameFail = false;
        timer.cancel();
      }
    });
  }

  void moveBarrier() {
    Timer.periodic(Duration(milliseconds: 30), (timer) {
      posFirstXBarrier -= 5;
      posSecondXBarrier -= 5;
      posThirdXBarrier -= 5;
      if (widthScreen / 2 + 35 <= posFirstXBarrier &&
          posFirstXBarrier <= widthScreen / 2 + 40) {
        ++score;
      }
      if (widthScreen / 2 + 35 <= posSecondXBarrier &&
          posSecondXBarrier <= widthScreen / 2 + 40) {
        ++score;
      }
      if (widthScreen / 2 + 35 <= posThirdXBarrier &&
          posThirdXBarrier <= widthScreen / 2 + 40) {
        ++score;
      }
      if (posFirstXBarrier < -80) {
        posFirstXBarrier = widthScreen+80;
        firstHeightUp = values.getUp();
        firstHeightDown = values.getDown(firstHeightUp);
      }
      if (posSecondXBarrier < -80) {
        posSecondXBarrier = posFirstXBarrier + widthScreen/2;
        secondHeightUp = values.getUp();
        secondHeightDown = values.getDown(secondHeightUp);
      }
      if (posThirdXBarrier < -80) {
        posThirdXBarrier = posSecondXBarrier + widthScreen/2;
        thirdHeightUp = values.getUp();
        thirdHeightDown = values.getDown(thirdHeightUp);
      }
      if (!gameIsStart) {
        timer.cancel();
      }
      checkCollisionUp1();
      checkCollisionDown1();
      checkCollisionUp2();
      checkCollisionDown2();
      checkCollisionUp3();
      checkCollisionDown3();
    });
  }

  void showResultGame() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              title: Center(
                child: Text(
                  print2,
                  style: TextStyle(fontSize: 28),
                ),
              ),
              content: Container(
                  height: heightScreen / 2 - heightScreen / 3,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Score: $score",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text("Best Score: $bestScore",
                            style: TextStyle(fontSize: 25))
                      ],
                    ),
                  )),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        score = 0;
                      });
                    },
                    child: Text(
                      print3,
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ));
  }

  void checkCollisionUp1(){
    int heightUpTemp1 = 15 + 150 + firstHeightDown.toInt();

    bool flag1 = false;
    if ((birdX >= posFirstXBarrier && birdX <= posFirstXBarrier + 60) ||
        (birdX + 56 >= posFirstXBarrier && birdX + 56 <= posFirstXBarrier + 60)) {
      flag1 = true;
    }
    if(flag1){
      flag1 = false;
      if(birdY+30 > heightUpTemp1){
        gameFail = true;
      }
    }
  }

  void checkCollisionUp2(){
    int heightUpTemp2 = 15 + 150 + secondHeightDown.toInt();

    bool flag2 = false;
    if ((birdX >= posSecondXBarrier && birdX <= posSecondXBarrier + 60) ||
        (birdX + 56 >= posSecondXBarrier && birdX + 56 <= posSecondXBarrier + 60)) {
      flag2 = true;
    }
    if(flag2){
      flag2 = false;
      if(birdY+30 > heightUpTemp2){
        gameFail = true;
      }
    }
  }

  void checkCollisionUp3(){
    int heightUpTemp3 = 15 + 150 + thirdHeightDown.toInt();

    bool flag3 = false;
    if ((birdX >= posThirdXBarrier && birdX <= posThirdXBarrier + 60) ||
        (birdX + 56 >= posThirdXBarrier && birdX + 56 <= posThirdXBarrier + 60)) {
      flag3 = true;
    }
    if(flag3){
      flag3 = false;
      if(birdY+30 > heightUpTemp3){
        gameFail = true;
      }
    }
  }

  void checkCollisionDown1() {
    bool flag1 = false;
    if ((birdX >= posFirstXBarrier && birdX <= posFirstXBarrier + 60) ||
        (birdX + 56 >= posFirstXBarrier && birdX + 56 <= posFirstXBarrier + 60)) {
      flag1 = true;
    }
    if(flag1){
      flag1 = false;
      if(birdY+10 < firstHeightDown){
        gameFail = true;
      }
    }
  }

  void checkCollisionDown2() {
    bool flag2 = false;
    if ((birdX >= posSecondXBarrier && birdX <= posSecondXBarrier + 60) ||
        (birdX + 56 >= posSecondXBarrier && birdX + 56 <= posSecondXBarrier + 60)) {
      flag2 = true;
    }
    if(flag2){
      flag2 = false;
      if(birdY+10 < secondHeightDown){
        gameFail = true;
      }
    }
  }

  void checkCollisionDown3() {
    bool flag3 = false;
    if ((birdX >= posThirdXBarrier && birdX <= posThirdXBarrier + 60) ||
        (birdX + 56 >= posThirdXBarrier && birdX + 56 <= posThirdXBarrier + 60)) {
      flag3 = true;
    }
    if(flag3){
      flag3 = false;
      if(birdY+10 < thirdHeightDown){
        gameFail = true;
      }
    }
  }
}
