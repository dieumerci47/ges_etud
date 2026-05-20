// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ges_etud/colors/app_theme.dart';
import 'package:ges_etud/main.dart';
import 'package:ges_etud/provider/etudiant_provider.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class FicheDetailPage extends StatefulWidget {
  final int id;
  const FicheDetailPage({super.key, required this.id});

  @override
  State<FicheDetailPage> createState() => _FicheDetailPageState();
}

class _FicheDetailPageState extends State<FicheDetailPage> {
  late Future _futureEtudiant;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final etudiant = Provider.of<EtudiantProvider>(context, listen: false);
    _futureEtudiant = etudiant.getEtudiant(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: d_blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Retour à la liste"),
      ),
      body: FutureBuilder(
        future: _futureEtudiant,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // État 2 : Erreur → afficher un message d'erreur
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }
          // print(snapshot.data);
          return SingleChildScrollView(
            child: Column(children: [_infos(snapshot.data)]),
          );
        },
      ),
    );
  }

  Widget _infos(Map etudiant) {
    Color getStatutColor(String statut) {
      return switch (statut) {
        'actif' => AppColors.statusActive,
        'inactif' => AppColors.statusInactive,
        'conge' => AppColors.statusLeave,
        'diplome' => AppColors.statusGraduate,
        'suspendu' => AppColors.statusSuspended,
        _ => Colors.transparent, // Cas par défaut (si le statut est inconnu)
      };
    }

    return Container(
      padding: EdgeInsets.only(right: 20, left: 30),

      margin: EdgeInsets.only(top: 10),
      color: d_blue,

      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  // padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.all(25),
                  child: Text(
                    etudiant['prenom']![0] + etudiant['nom']![0] ?? "",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  /* CircleAvatar(
              radius: 25,
              backgroundColor: Colors
                  .primaries[Random().nextInt(Colors.primaries.length)]
                  .shade200,
              foregroundColor: d_blue,
              child: Text(etudiant['prenom']![0] + etudiant['nom']![0] ?? ""),
            ), */
                ),
                SizedBox(width: 10),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      etudiant['nom_complet'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${etudiant['matricule'] ?? ""} - ${etudiant['promotion_code'] ?? ""}",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      etudiant['filiere_nom'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.only(right: 5, left: 5),
                      decoration: BoxDecoration(
                        color: getStatutColor(
                          etudiant["statut"],
                        ).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        ".${etudiant['statut']}",
                        style: TextStyle(
                          color: Colors.white,
                          // color: getStatutColor(etudiant["statut"]),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bouttonInfos(label: "Modifier", icon: Icons.edit_square),
                _bouttonInfos(
                  label: "Supprimer",
                  icon: Icons.delete_forever_outlined,
                ),
                _bouttonInfos(label: "Partager", icon: LucideIcons.share2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bouttonInfos({required String label, required IconData icon}) {
    return /* Container(
      // width: double.infinity,
      // height: 20,
      color: Colors.red,
      child: */ TextButton(
      onPressed: () {
        print(label);
      },
      style: TextButton.styleFrom(
        iconColor: label != "Supprimer" ? Colors.white : Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: label != "Supprimer" ? Colors.white : Colors.red,
            ),
          ),
        ],
      ),
    );
    // );
  }
}
