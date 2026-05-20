import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:ges_etud/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProvider with ChangeNotifier {
  // final Map _admin = {};
  Map _admin = {};
  Map get admin => _admin;
  Map _adminInfos = {};
  Map get adminInfos => _adminInfos;
  final dio = Dio();
  // final String ip = "192.168.1.94:3001";
  final String ip = "192.168.100.254:3001";

  Future logAdmin(String email, String password) async {
    try {
      final url = "http://$ip/api/login";
      final response = await dio.post(
        url,
        data: {"email": email, "password": password},
      );

      _admin = response.data;
      // Après le login réussi :
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', response.data['token']);
      await prefs.setInt('adminId', response.data['adminId']);

      notifyListeners();
      return _admin;
    } on DioException catch (e) {
      // e.response contient la réponse du serveur (si elle existe)
      if (e.response != null) {
        // Ici vous pouvez lire le code d'erreur et le message
        print("Erreur ${e.response!.statusCode}: ${e.response!.data}");
        // ex: "Erreur 404: {error: 'admin not found'}"
      } else {
        // Pas de réponse du serveur (pas de connexion, timeout, etc.)
        print("Erreur réseau: ${e.message}");
      }
      _admin = {};
      notifyListeners();
      return _admin;
    }
  }

  Future getInfosAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('adminId');
    final url = "http://$ip/api/admin";
    final response = await dio.get(url, data: {"id": adminId});
    _adminInfos = response.data['admin'];
    // print(response.data);
    // print(_adminInfos);
    return _adminInfos;
  }

  Future logoutAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('adminId');
    prefs.remove('jwt');
    final url = "http://$ip/api/logout";
    await dio.get(url);
    // final response = await dio.get(url);
    /* _adminInfos = response.data;
    return _adminInfos; */
  }
}
