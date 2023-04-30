import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_daily/Screens/Finish.dart';
import 'Break.dart';
import 'package:yoga_daily/Model/model.dart';
import '/Services/localdb.dart';

class WorkOutDet extends StatelessWidget {
  List<Yoga> listOfYoga;
  int yogaindex;
  WorkOutDet({
    super.key,
    required this.listOfYoga,
    required this.yogaindex,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
      create: (context) => TimerModelSec(context, listOfYoga, yogaindex + 1,
          listOfYoga[yogaindex].secondsORtimes),
      child: Consumer<TimerModelSec>(
        builder: (context, myModel, child) {
          return WillPopScope(
            onWillPop: (() async {
              myModel.show();
              return false;
            }),
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    //margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        SafeArea(
                          child: Container(
                            height: 320,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        listOfYoga[yogaindex].yogaImgUrl))),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            listOfYoga[yogaindex].yogaTitle,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 80),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(50)),
                          child: listOfYoga[yogaindex].seconds
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("00",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    const Text(" : ",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Consumer<TimerModelSec>(
                                        builder: (context, myModel, child) {
                                      return Text(
                                          myModel.countdown.toString().length ==
                                                  1
                                              ? "0${myModel.countdown}"
                                              : myModel.countdown.toString(),
                                          style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold));
                                    }),
                                  ],
                                )
                              : Text(
                                  "x${listOfYoga[yogaindex].secondsORtimes}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                        ),
                        const Spacer(),
                        const SizedBox(
                          height: 30,
                        ),
                        Consumer<TimerModelSec>(
                            builder: (context, myModel, child) {
                          return ElevatedButton(
                              onPressed: (() {
                                myModel.show();
                              }),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: const Text(
                                    "PAUSE",
                                    style: TextStyle(fontSize: 20),
                                  )));
                        }),
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
                          thickness: 1,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                "Next: ${yogaindex >= listOfYoga.length - 1 ? "FINISH" : listOfYoga[yogaindex + 1].yogaTitle}",
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
                        child: Center(
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
                                          fontSize: 13,
                                        )),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WorkOutDet(
                                                          listOfYoga:
                                                              listOfYoga,
                                                          yogaindex: 0)));
                                        },
                                        child: const SizedBox(
                                            width: 180,
                                            child: Text(
                                              "RESTART",
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ))),
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const SizedBox(
                                            width: 180,
                                            child: Text(
                                              "QUIT",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                      child: const SizedBox(
                                          width: 180,
                                          child: Text(
                                            "RESUME",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 40, 75, 135)),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                  ],
                                ))),
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
  TimerModelSec(context, List<Yoga> listYoga, int yogaIndex, countdown) {
    setCntDownValue(int.parse(countdown), listYoga[yogaIndex - 1].seconds);
    checkIfLast(yogaIndex >= listYoga.length - 1);
    myTimerSec(context, listYoga, yogaIndex);
    readTime(yogaIndex);
  }
  int countdown = 0;
  bool isLast = false;

  void readTime(int yogaIndex) {
    if (yogaIndex == 1) {
      String now = DateTime.now().toString();
      LocalDB.setStartTime(now);
    }
  }

  void checkIfLast(bool ans) {
    isLast = ans;
  }

  void setCntDownValue(int count, bool isSec) {
    countdown = isSec ? count : 1000;
  }

  bool visible = false;
  bool isPassed = false;

  myTimerSec(context, List<Yoga> listYoga, int yogaIndex) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      visible ? countdown + 0 : countdown--;
      notifyListeners();
      if (countdown == 0) {
        timer.cancel();

        isLast
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Finish()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BreakTime(listOfYoga: listYoga, yogaindex: yogaIndex)));
        /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    BreakTime(listOfYoga: listYoga, yogaindex: yogaIndex))));*/
      } else if (isPassed) {
        timer.cancel();
      }
    });
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
