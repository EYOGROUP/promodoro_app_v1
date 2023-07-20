// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PromodoroApp(),
    );
  }
}

class PromodoroApp extends StatefulWidget {
  const PromodoroApp({super.key});

  @override
  State<PromodoroApp> createState() => _PromodoroAppState();
}

class _PromodoroAppState extends State<PromodoroApp> {
  Timer? timeCounter;
  int minute = 25;
  int second = 0;
  startCounter() {
    // second = 59;
    timeCounter = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // second--;
        if (minute >= 0) {
          second--;
        }
        if (second < 0) {
          minute--;
          second = 59;
        }
        if (minute == 0 && second == 0) {
          timer.cancel();
          isRunning = false;
          minute = 25;
          second = 0;
        }
      });
    });
  }

  cancelTimer() {
    if (timeCounter!.isActive) {
      setState(() {
        timeCounter!.cancel();
        isRunning = false;
        minute = 25;
        second = 0;
      });
    }
  }

  stopTimer() {
    if (timeCounter!.isActive) {
      setState(() {
        timeCounter!.cancel();
      });
    } else {
      startCounter();
    }
  }

  bool isRunning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 36, 41),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 26, 26, 32),
        title: Text(
          "Promodoro App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 120,
              progressColor: Colors.red,
              animation: true,
              lineWidth: 7,
              percent: minute / 25,
              animateFromLastPercent: true,
              animationDuration: 1000,
              center: Text(
                "${minute.toString()}:${second.toString().padLeft(2, "0")}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 68,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            isRunning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.pink.shade400),
                          minimumSize: MaterialStatePropertyAll(
                            Size(98, 35),
                          ),
                        ),
                        onPressed: () {
                          stopTimer();
                        },
                        child: Text(
                          timeCounter!.isActive ? "Stop" : "Resume",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.pink.shade400),
                          minimumSize: MaterialStatePropertyAll(
                            Size(98, 35),
                          ),
                        ),
                        onPressed: () {
                          cancelTimer();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                    onPressed: () {
                      startCounter();
                      setState(() {
                        isRunning = true;
                      });
                    },
                    child: Text(
                      "Start Studying",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
