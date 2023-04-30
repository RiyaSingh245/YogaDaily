import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_daily/Screens/WorkOutdet.dart';
import 'package:yoga_daily/Model/model.dart';
import 'package:yoga_daily/Services/yogadb.dart';
import 'dart:math';

class rUready extends StatelessWidget {
  String yogaTableName;
  rUready({super.key, required this.yogaTableName});

  T getRandomElement<T>(List<T> list) {
    final random = Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  var list = [
    'Create a comfortable spot for your yoga practice',
    'Yoga can ease arthritis symptoms.',
    'Yoga benefits heart health.',
    'Yoga relaxes you, to help you sleep better.',
    'Yoga can mean more energy and brighter moods.',
    'Yoga helps you manage stress.'
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModel>(
      create: (context) => TimerModel(context, yogaTableName: yogaTableName),
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                ),
                const Text(
                  "ARE YOU READY",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<TimerModel>(builder: (context, myModel, child) {
                  return Text(
                    myModel.countdown.toString(),
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.bold),
                  );
                }),
                const Spacer(),
                const Divider(
                  thickness: 1,
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        "Tip: ${getRandomElement(list)}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerModel with ChangeNotifier {
  String yogaTableName;
  TimerModel(context, {required this.yogaTableName}) {
    fetchAllYoga(yogaTableName);
    myTimer(context);
  }
  int countdown = 5;
  List<Yoga> allYoga = [];
  myTimer(context) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      if (countdown == 0) {
        timer.cancel();
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => WorkOutDet(
                      listOfYoga: allYoga,
                      yogaindex: 0,
                    ))));
      }

      notifyListeners();
    });
  }

  Future<List<Yoga>> fetchAllYoga(String yogaTableName) async {
    await YogaDatabase.instance.readAllYogaSum();
    allYoga = await YogaDatabase.instance.readAllYoga(yogaTableName);
    print(allYoga.length);
    notifyListeners();
    return allYoga;
  }
}
