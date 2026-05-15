import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ges_etud/pages/onboarding_page.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    loadAnimation();
  }

  Future<Timer> loadAnimation() async {
    return Timer(Duration(seconds: 3), () {
      onLoaded();
    });
  }

  onLoaded() {
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
