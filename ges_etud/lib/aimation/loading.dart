import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ges_etud/pages/home_page.dart';
import 'package:ges_etud/pages/login/login_page.dart';
import 'package:ges_etud/pages/onboarding_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/sharedPreferences.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final dio = Dio();
  final String ip = "192.168.100.254:3001";
  @override
  void initState() {
    super.initState();
    loadAnimation();
  }

  Future<Map> verrifyToken(String token) async {
    final url = "http://$ip/api/verify";
    final res = await dio.get(
      url,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    // print(res.data);
    return res.data;
  }

  Future<Timer> loadAnimation() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');

    return Timer(Duration(seconds: 3), () async {
      if (token != null) {
        try {
          // print(await verrifyToken(token));
          final rep = await verrifyToken(token);
          if (rep.containsKey("adminId")) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          }
        } on DioException catch (e) {
          if (e.response!.statusCode == 401) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } /* else {
            
          } */
        }
        /*  Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        ); */
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingPage()),
        );
      }
    });
  }

  void onLoaded() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnBoardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Lottie.asset("assets/lotties/gesetu_lottie.json", repeat: true),
        child: Lottie.asset("assets/lotties/ges_etu_logo.json", repeat: false),
      ),
    );
  }
}
