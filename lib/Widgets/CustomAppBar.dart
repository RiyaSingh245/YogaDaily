import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  AnimationController animationController;
  Animation colorsTween, homeTween, yogaTween, drawerTween, iconTween;
  Function()? onPressed;

  CustomAppBar(
      {super.key,
      required this.animationController,
      required this.colorsTween,
      required this.homeTween,
      required this.yogaTween,
      required this.drawerTween,
      required this.iconTween,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.dehaze,
              color: drawerTween.value,
            ),
            onPressed: onPressed,
          ),
          backgroundColor: colorsTween.value,
          elevation: 0,
          title: Row(
            children: [
              Text(
                "HOME",
                style: TextStyle(
                  color: homeTween.value,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "YOGA",
                style: TextStyle(
                    color: yogaTween.value,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 1),
              )
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("No New Notifications"),
                ));
              },
              color: iconTween.value,
            ),
          ],
        ),
      ),
    );
  }
}
