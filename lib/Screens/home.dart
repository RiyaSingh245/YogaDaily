import 'package:flutter/material.dart';
import 'package:yoga_daily/Screens/Startup.dart';
import 'package:yoga_daily/Services/yogadb.dart';
import '../Model/model.dart';
import '../Widgets/CustomAppBar.dart';
import '/Widgets/CustomDrawer.dart';
import 'package:yoga_daily/Services/localdb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _homeTween, _drawerTween, _iconTween, _colorsTween, _yogaTween;
  late AnimationController _textAnimationController;

  bool isLoading = true;
  List<YogaSummary> yogaSumList = [];
  Future readYogaSum() async {
    yogaSumList = await YogaDatabase.instance.readAllYogaSum();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _colorsTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_animationController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.lightBlue)
        .animate(_animationController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _homeTween = ColorTween(begin: Colors.white, end: Colors.blue)
        .animate(_animationController);
    _yogaTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _textAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    super.initState();

    /*makeYogaSumEntry(YogaSummary(
        workOutName: YogaModel.yogaTable1,
        bgimageName:
            "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1220&q=80CKIMAGURL",
        timeTaken: "timeTaken",
        noOfWorkOut: "noOfWorkOut",
        yogaKey: 1));

    makeYogaEntry(
      Yoga(
          seconds: false,
          yogaImgUrl:
              "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w",
          yogaTitle: "SECOND ASAN",
          secondsORtimes: '16',
          yogaKeyWorkout: 1),
      YogaModel.yogaTable1,
    );

    makeYogaEntry(
      Yoga(
          seconds: true,
          yogaTitle: "Anulom Vilom",
          yogaImgUrl:
              "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w",
          secondsORtimes: "30",
          yogaKeyWorkout: 1),
      YogaModel.yogaTable1,
    );

    makeYogaEntry(
        Yoga(
            seconds: true,
            yogaTitle: "pravasana",
            yogaImgUrl:
                "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w",
            secondsORtimes: "30",
            yogaKeyWorkout: 1),
        YogaModel.yogaTable1);

    makeYogaEntry(
        Yoga(
          seconds: true,
          yogaTitle: "Kapal bharti",
          yogaImgUrl:
              "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w",
          secondsORtimes: "20",
          yogaKeyWorkout: 1,
        ),
        YogaModel.yogaTable1);

    makeYogaEntry(
        Yoga(
          seconds: true,
          yogaTitle: "Asana",
          yogaImgUrl:
              "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w",
          secondsORtimes: "15",
          yogaKeyWorkout: 1,
        ),
        YogaModel.yogaTable1);*/
    getFitnessData();
    readYogaSum();
  }

  int? streak;
  int? kcal;
  int? womin;
  void getFitnessData() async {
    streak = await LocalDB.getStreak();
    kcal = await LocalDB.getKcal();
    womin = await LocalDB.getWorkOutTime();
    setState(() {});
  }

  bool scrollListener(ScrollNotification scrollNotification) {
    bool scroll = false;
    if (scrollNotification.metrics.axis == Axis.vertical) {
      _animationController.animateTo(scrollNotification.metrics.pixels / 80);
      _textAnimationController.animateTo(scrollNotification.metrics.pixels);
      return scroll = true;
    }
    return scroll;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(),
          )
        : Scaffold(
            key: scaffoldKey,
            drawer: const CustomDrawer(),
            backgroundColor: Colors.white,
            body: NotificationListener(
                onNotification: scrollListener,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 120, 50, 30),
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                streak.toString() == "null"
                                                    ? "0"
                                                    : streak.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const Text(
                                                "Streak",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                kcal.toString() == "null"
                                                    ? "0"
                                                    : kcal.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              const Text(
                                                "KCal",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                womin.toString() == "null"
                                                    ? "0"
                                                    : womin.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              const Text(
                                                "mins",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: const Text(
                                              "Yoga For All",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: yogaSumList.length,
                                              itemBuilder: ((context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    StartUp(
                                                                      yogaKey: yogaSumList[
                                                                              index]
                                                                          .yogaKey
                                                                          .toString(),
                                                                      yogaSum:
                                                                          yogaSumList[
                                                                              index],
                                                                    )));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                yogaSumList[
                                                                        index]
                                                                    .bgimageName
                                                                    .toString()),
                                                          )),
                                                        ),
                                                        Container(
                                                          height: 150,
                                                          color: Colors.black26,
                                                        ),
                                                        Positioned(
                                                            right: 20,
                                                            left: 10,
                                                            top: 10,
                                                            child: Text(
                                                              yogaSumList[index]
                                                                  .workOutName,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            )),
                                                        Positioned(
                                                            right: 30,
                                                            left: 10,
                                                            top: 38,
                                                            child: Text(
                                                              yogaSumList[index]
                                                                  .timeTaken,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })),
                                          /*InkWell(
                                            onTap: () {
                                              /*Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                   StartUp(yogaKey: yogaSumList[index].yogaKey.toString(), yogaSum: yogaSumList[index],)));*/
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    decoration:
                                                        const BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=920&q=80"),
                                                    )),
                                                  ),
                                                  Container(
                                                    height: 150,
                                                    color: Colors.black26,
                                                  ),
                                                  const Positioned(
                                                      right: 20,
                                                      left: 10,
                                                      top: 10,
                                                      child: Text(
                                                        "Yoga For Beginners",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      )),
                                                  const Positioned(
                                                      right: 30,
                                                      left: 10,
                                                      top: 38,
                                                      child: Text(
                                                        "Last Time : 2 Feb",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),*/
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.blue),
                                              child: Column(
                                                children: const [
                                                  Text(
                                                    "Next Yoga Workout Pack Update On",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "10",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "App Installs",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ))
                                          /*Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 150,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "https://images.unsplash.com/photo-1510894347713-fc3ed6fdf539?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"))),
                                                ),
                                                Container(
                                                  height: 150,
                                                  color: Colors.black26,
                                                ),
                                                const Positioned(
                                                  right: 20,
                                                  left: 10,
                                                  top: 10,
                                                  child: Text(
                                                    "Weight Loss Yoga",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                const Positioned(
                                                  right: 30,
                                                  left: 12,
                                                  top: 38,
                                                  child: Text(
                                                    "Last Time : 22 Jan",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 150,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "https://images.unsplash.com/photo-1573590330099-d6c7355ec595?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"))),
                                                ),
                                                Container(
                                                  height: 150,
                                                  color: Colors.black26,
                                                ),
                                                const Positioned(
                                                  right: 20,
                                                  left: 10,
                                                  top: 10,
                                                  child: Text(
                                                    "Suryanamaskar",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                const Positioned(
                                                  right: 30,
                                                  left: 12,
                                                  top: 38,
                                                  child: Text(
                                                    "Last Time : Yesterday",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: const Text(
                                              "Choose Your Type",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 150,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"))),
                                                ),
                                                Container(
                                                  height: 150,
                                                  color: Colors.black26,
                                                ),
                                                const Positioned(
                                                  right: 20,
                                                  left: 10,
                                                  top: 10,
                                                  child: Text(
                                                    "Power Yoga",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                const Positioned(
                                                  right: 30,
                                                  left: 12,
                                                  top: 38,
                                                  child: Text(
                                                    "Last Time : Yesterday",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 150,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "https://media.istockphoto.com/photos/young-woman-in-yoga-pose-using-laptop-at-home-picture-id1334071264?b=1&k=20&m=1334071264&s=170667a&w=0&h=0wnQzJJJIA5NMo6dOmVepS6mXC0eqLjI26ADDlIK4Lg="))),
                                                ),
                                                Container(
                                                  height: 150,
                                                  color: Colors.black26,
                                                ),
                                                const Positioned(
                                                  right: 20,
                                                  left: 10,
                                                  top: 10,
                                                  child: Text(
                                                    "Breathing Yoga",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                const Positioned(
                                                  right: 30,
                                                  left: 12,
                                                  top: 38,
                                                  child: Text(
                                                    "Last Time : 29 Jan",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 150,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "https://images.unsplash.com/photo-1556816723-1ce827b9cfbb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=792&q=80"))),
                                                ),
                                                Container(
                                                  height: 150,
                                                  color: Colors.black26,
                                                ),
                                                const Positioned(
                                                  right: 20,
                                                  left: 10,
                                                  top: 10,
                                                  child: Text(
                                                    "Increase Flexibility",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                const Positioned(
                                                  right: 30,
                                                  left: 12,
                                                  top: 38,
                                                  child: Text(
                                                    "Last Time : 29 Jan",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CustomAppBar(
                            animationController: _animationController,
                            colorsTween: _colorsTween,
                            homeTween: _homeTween,
                            yogaTween: _yogaTween,
                            drawerTween: _drawerTween,
                            iconTween: _iconTween,
                            onPressed: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                )),
          );
  }
}
