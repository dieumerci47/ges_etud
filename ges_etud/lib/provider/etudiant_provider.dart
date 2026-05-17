import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EtudiantProvider with ChangeNotifier {
  final dio = Dio();
  final String ip = "192.168.100.254:3001";

  List _etudiants = [];
  List get listeEtudiant => _etudiants;
  Map _dashboard = {};
  Map get tableauDashboard => _dashboard;

  Future getListeEtudiants() async {
    try {
      final url = "http://$ip/api/etudiants";
      final response = await dio.get(
        url,
        // data: {"email": email, "password": password},
      );

      _etudiants = response.data;
      // print(_etudiants);
      return _etudiants;
    } catch (e) {
      print(e);
    }
  }

  Future getDashboard() async {
    try {
      final url = "http://$ip/api/dashboard";
      final response = await dio.get(
        url,
        // data: {"email": email, "password": password},
      );

      _dashboard = response.data;
      // print(_etudiants);
      return _etudiants;
    } catch (e) {
      print(e);
    }
  }
}
