import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import '/Screens/SplashScreen.dart';
import '/Services/localdb.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Future<void> shareApp() async {
    await FlutterShare.share(
        title: 'Hey I am using Yoga_daily App',
        text:
            'Hey I am using Yoga_daily App. It has best yoga workout for all age groups. You should try it once.',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1545389336-cf090694435e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80"),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              "Reset Progress",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: const Icon(Icons.restart_alt_sharp, size: 25),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('RESET PROGRESS'),
                  actionsAlignment: MainAxisAlignment.center,
                  actionsPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  content: const Text(
                      'This will reset all of your fitness data including Total Workout Time, Streak and Burned Calories. The action cannot be revert once done.'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 35))),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await LocalDB.setWorkOutTime(0);
                          await LocalDB.setkcal(0);
                          await LocalDB.setStreak(0);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SplashScreen()));
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 35))),
                        child: const Text(
                          "Reset",
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Share with Friends",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: const Icon(Icons.share, size: 25),
            onTap: shareApp,
          ),
          ListTile(
            title: const Text(
              "Rate Us",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: const Icon(Icons.star, size: 25),
            onTap: () async {
              await launchUrl(Uri.parse(
                  "https://play.google.com/store/apps/details?id=com.dhruv.aiem"));
            },
          ),
          const ListTile(
            title: Text(
              "Feedback",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: Icon(Icons.comment, size: 25),
          ),
          ListTile(
            title: const Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            leading: const Icon(Icons.security, size: 25),
            onTap: () async {
              await launchUrl(Uri.parse(
                  "https://sites.google.com/view/yogaforbeginners-indianyoga/privacy-policy"));
            },
          ),
          const Divider(
            thickness: 2,
            indent: 30,
            endIndent: 30,
          ),
          const Text(
            "Version 1.0.0",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
