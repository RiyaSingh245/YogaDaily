import 'package:flutter/material.dart';
import 'home.dart';
import 'package:yoga_daily/Model/model.dart';
import '/Services/localdb.dart';
import 'package:yoga_daily/Services/yogadb.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future makeYogaEntry(Yoga yoga, String tableName) async {
    await YogaDatabase.instance.insert(yoga, tableName);
  }

  Future makeYogaSumEntry(YogaSummary yogaSummary) async {
    await YogaDatabase.instance.insertYogaSum(yogaSummary);
  }

  checkUp() async {
    await LocalDB.getFirstTime().then((value) async {
      if (value.toString() == "null" || value != false) {
        await LocalDB.setStreak(0);
        await LocalDB.setLastDoneOn(
            DateTime.now().subtract(const Duration(days: 1)).toString());
        await LocalDB.setkcal(0);
        await LocalDB.setWorkOutTime(0);
        await LocalDB.setFirstTime(false);

        // CREATING ONE YOGA WORKOUT PACK
        makeYogaSumEntry(YogaSummary(
            workOutName: YogaModel.yogaTable1,
            bgimageName: "assets/01_Suryanamskar/main.jpg",
            timeTaken: "6",
            noOfWorkOut: "12",
            yogaKey: 1));
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/1.png",
              yogaTitle: "Pranamasana (Prayer pose)",
              secondsORtimes: '15',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/2.png",
              yogaTitle: "Hastauttanasana (Raised arms pose)",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/3.png",
              yogaTitle: "Uttanasana (Standing forward bend)",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/4.png",
              yogaTitle: "Ardha Uttanasana (half-standing forward bend)",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/5.png",
              yogaTitle: "Exhale and return to the forward fold",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/6.png",
              yogaTitle: "Get into a plank pose",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/7.png",
              yogaTitle: "Lower yourself into a low pushup",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/8.png",
              yogaTitle:
                  "Urdhva Mukha Svanasana(Inhale and enter an upward dog pose)",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/9.png",
              yogaTitle: "Adho Mukha Svanasana (downward dog pose)",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/10.png",
              yogaTitle: "Move back into the standing forward bend",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/11.png",
              yogaTitle: "Inhale and move back into the upward salute",
              secondsORtimes: '30',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
        makeYogaEntry(
          Yoga(
              seconds: true,
              yogaImgUrl: "assets/01_Suryanamskar/12.png",
              yogaTitle: "Exhale and return to the mountain pose",
              secondsORtimes: '15',
              yogaKeyWorkout: 1),
          YogaModel.yogaTable1,
        );
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    checkUp();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
    //CHECK INSTALLATION,INSERT,READ,UPDATE,OPERATION STATUS
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/logo/yoga_trasparent.png")),
    );
  }
}
