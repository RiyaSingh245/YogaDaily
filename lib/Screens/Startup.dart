import 'package:flutter/material.dart';
import 'package:yoga_daily/Screens/rUready.dart';
import 'package:yoga_daily/Model/model.dart';
import 'package:yoga_daily/Services/yogadb.dart';

class StartUp extends StatefulWidget {
  String yogaKey;
  YogaSummary yogaSum;
  StartUp({super.key, required this.yogaKey, required this.yogaSum});

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  void initState() {
    super.initState();
    readYoga();
  }

  List<Yoga> allYogaWorkout = [];
  bool isLoading = true;
  Future readYoga() async {
    allYogaWorkout =
        await YogaDatabase.instance.readAllYoga(widget.yogaSum.workOutName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Container(),
          )
        : Scaffold(
            floatingActionButton: ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => rUready(
                                yogaTableName: widget.yogaSum.workOutName,
                              ))));
                }),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: const Text(
                      "START",
                      style: TextStyle(fontSize: 18),
                    ))),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    title: Text(widget.yogaSum.workOutName),
                    background: Image.asset(
                      widget.yogaSum.bgimageName.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: (() {}),
                        icon: const Icon(Icons.thumb_up_alt_outlined))
                  ],
                ),
                SliverToBoxAdapter(
                    child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                              "${widget.yogaSum.timeTaken} Mins || ${widget.yogaSum.noOfWorkOut} Workouts",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: ((context, index) => const Divider(
                                thickness: 2,
                              )),
                          itemBuilder: ((context, index) => ListTile(
                                leading: Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      allYogaWorkout[index].yogaImgUrl,
                                      fit: BoxFit.cover,
                                    )),
                                title: Text(
                                  allYogaWorkout[index].yogaTitle,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    allYogaWorkout[index].seconds
                                        ? "00:${allYogaWorkout[index].secondsORtimes}"
                                        : "x${allYogaWorkout[index].secondsORtimes}",
                                    style: const TextStyle(fontSize: 15)),
                              )),
                          itemCount: allYogaWorkout.length),
                    ],
                  ),
                )),
              ],
            ),
          );
  }
}
