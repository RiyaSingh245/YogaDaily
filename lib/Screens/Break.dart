import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_daily/Screens/WorkOutdet.dart';
import '../Model/model.dart';

class BreakTime extends StatelessWidget {
  List<Yoga> listOfYoga;
  int yogaindex;
  BreakTime({super.key, required this.listOfYoga, required this.yogaindex});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
      create: (context) => TimerModelSec(context, listOfYoga, yogaindex),
      child: Consumer<TimerModelSec>(
        builder: (context, myModel, child) {
          return WillPopScope(
            onWillPop: (() async {
              myModel.show();
              return false;
            }),
            child: Scaffold(
              backgroundColor: Colors.blue,
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    /*decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1558017487-06bf9f82613a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=470&q=80"))),*/
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        const Text("Break Time",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        Consumer<TimerModelSec>(
                            builder: (context, myModel, child) {
                          return Text(myModel.countdown.toString(),
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold));
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<TimerModelSec>(
                          builder: (context, myModel, child) {
                            return ElevatedButton(
                                onPressed: (() {
                                  myModel.skip();
                                }),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  child: Text(
                                    "SKIP",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ));
                          },
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              yogaindex != 0
                                  ? Consumer<TimerModelSec>(
                                      builder: (context, myModel, child) {
                                        return TextButton(
                                            onPressed: (() async {
                                              myModel.Pass();
                                              await Future.delayed(
                                                  Duration(seconds: 1));
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BreakTime(
                                                              listOfYoga:
                                                                  listOfYoga,
                                                              yogaindex:
                                                                  yogaindex -
                                                                      1)));
                                              /*Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WorkOutDet(
                                                  listOfYoga: listOfYoga,
                                                  yogaindex: yogaindex - 1)));*/
                                            }),
                                            child: const Text(
                                              "PREVIOUS",
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 16),
                                            ));
                                      },
                                    )
                                  : Container(),
                              yogaindex != listOfYoga.length - 1
                                  ? Consumer<TimerModelSec>(
                                      builder: (context, myModel, child) {
                                        return TextButton(
                                            onPressed: (() async {
                                              myModel.Pass();
                                              await Future.delayed(
                                                  Duration(seconds: 1));
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BreakTime(
                                                              listOfYoga:
                                                                  listOfYoga,
                                                              yogaindex:
                                                                  yogaindex +
                                                                      1)));
                                              /*Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WorkOutDet(
                                                  listOfYoga: listOfYoga,
                                                  yogaindex: yogaindex + 1)));*/
                                            }),
                                            child: const Text(
                                              "NEXT",
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 16),
                                            ));
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                "Next: ${yogaindex >= listOfYoga.length - 1 ? "FINISH" : listOfYoga[yogaindex].yogaTitle}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Consumer<TimerModelSec>(
                    builder: (context, myModel, child) {
                      return Visibility(
                        visible: myModel.visible,
                        child: Container(
                            color: Colors.blueAccent.withOpacity(0.9),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Pause",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("YOGA FEELS BETTER",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WorkOutDet(
                                                  listOfYoga: listOfYoga,
                                                  yogaindex: 0)));
                                    },
                                    child: Container(
                                        width: 180,
                                        child: const Text(
                                          "RESTART",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ))),
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        width: 180,
                                        child: const Text(
                                          "QUIT",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ))),
                                OutlinedButton(
                                  onPressed: () {
                                    myModel.hide();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  child: Container(
                                      width: 180,
                                      child: const Text(
                                        "RESUME",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 40, 75, 135)),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TimerModelSec with ChangeNotifier {
  TimerModelSec(context, List<Yoga> yogaList, int yogaIndex) {
    myTimerSec(context, yogaList, yogaIndex);
  }
  int countdown = 10;
  bool isSkip = false;
  bool isPassed = false;
  bool visible = false;
  myTimerSec(context, List<Yoga> yogaList, int yogaIndex) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      visible ? countdown + 0 : countdown--;
      notifyListeners();
      if (countdown == 0 || isSkip) {
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    WorkOutDet(listOfYoga: yogaList, yogaindex: yogaIndex))));
      } else if (isPassed) {
        timer.cancel();
      }
    });
  }

  void skip() {
    isSkip = true;
    notifyListeners();
  }

  void show() {
    visible = true;
    notifyListeners();
  }

  void hide() {
    visible = false;
    notifyListeners();
  }

  void Pass() {
    isPassed = true;
    notifyListeners();
  }
}
