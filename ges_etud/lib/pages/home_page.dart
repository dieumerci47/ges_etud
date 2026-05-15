import 'package:flutter/material.dart';
import 'package:ges_etud/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: d_blue),
      body: ListView(padding: EdgeInsets.all(20), children: [Text("data")]),
    );
  }
}
