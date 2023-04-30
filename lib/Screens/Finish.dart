import 'package:flutter/material.dart';
import 'package:yoga_daily/Services/localdb.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Finish extends StatelessWidget {
  const Finish({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UpdateFitnessModel>(
      create: (context) => UpdateFitnessModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              //margin: EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    "https://media.istockphoto.com/id/1168757141/vector/gold-trophy-with-the-name-plate-of-the-winner-of-the-competition.jpg?s=612x612&w=0&k=20&c=ljsP4p0yuJnh4f5jE2VwXfjs96CC0x4zj8CHUoMo39E=",
                    width: 350,
                    height: 320,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text(
                        "125",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Kcal",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Mins",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "DO IT AGAIN",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "SHARE",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Container(
              //margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 50),
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: (() {}),
                      child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            "Rate Our App",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ))),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: Colors.grey,
            ),
            Consumer<UpdateFitnessModel>(builder: (context, myModel, child) {
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}

class UpdateFitnessModel with ChangeNotifier {
  UpdateFitnessModel() {
    setWorkoutTime();
    lastWorkOutDoneOn();
    setMyKcal(13);
  }
  int a = 1;

  void setWorkoutTime() async {
    String? startTime = await LocalDB.getStartTime();
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss")
        .parse(startTime ?? "2023-02-24 19:31:15.182");
    int difference = DateTime.now().difference(tempDate).inMinutes;
    int? mywotime = await LocalDB.getWorkOutTime();
    print(mywotime);
    await LocalDB.setWorkOutTime(mywotime! + difference);
  }

  void lastWorkOutDoneOn() async {
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss")
        .parse(await LocalDB.getLastDoneOn() ?? "2023-02-24 19:31:15.182");
    int difference = DateTime.now().difference(tempDate).inDays;
    if (difference == 0) {
    } else {
      int? streaknow = await LocalDB.getStreak();
      LocalDB.setStreak(streaknow! + 1);
    }
    await LocalDB.setLastDoneOn(DateTime.now().toString());
  }

  void setMyKcal(int myKCAL) async {
    int? kcal = await LocalDB.getKcal();
    await LocalDB.setkcal(kcal.toString() == "null" ? 0 : kcal! + myKCAL);
  }
}
