import 'package:flutter/material.dart';
import 'package:ges_etud/aimation/delayed_animtion.dart';
// import 'package:ges_etud/main.dart';

class OnBoarding extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  const OnBoarding({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.all(20),
      child: Column(
        // mainAxisSize: MainAxisSize.,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          DelayedAnimation(
            delay: 500,
            child: Container(
              alignment: Alignment.center,
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.25),
              ),
              child: Container(
                alignment: Alignment.center,
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.15),
                ),
                child: Icon(icon, size: 50, color: Colors.white),
              ),
            ),
          ),

          SizedBox(height: 10),
          //DEST
          DelayedAnimation(
            delay: 500,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
              // padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          //TITlE
          DelayedAnimation(
            delay: 500,
            child: Container(
              margin: EdgeInsets.all(10),

              // padding: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
              // padding: EdgeInsets.all(10),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 10),
          // DESCRIPTION
          DelayedAnimation(
            delay: 500,
            child: Container(
              margin: EdgeInsets.all(10),

              // padding: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
              // padding: EdgeInsets.all(10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 22,

                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Text("subtitle"),
        ],
      ),
    );
  }
}
