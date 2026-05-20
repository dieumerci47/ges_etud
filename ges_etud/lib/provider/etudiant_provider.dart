import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EtudiantProvider with ChangeNotifier {
  final dio = Dio();
  // final String ip = "192.168.1.94:3001";
  final String ip = "192.168.100.254:3001";

  List _etudiants = [];
  List get listeEtudiant => _etudiants;

  Map _oneEtudiant = {};
  Map get etudiant => _oneEtudiant;

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

  Future getEtudiant(int id) async {
    try {
      final url = "http://$ip/api/etudiant/${id.toString()}";
      print(url);
      final response = await dio.get(
        url,
        // data: {"email": email, "password": password},
      );

      _oneEtudiant = response.data;
      // print(_etudiants);
      return _oneEtudiant;
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
      return _dashboard;
    } catch (e) {
      print(e);
    }
  }
}
