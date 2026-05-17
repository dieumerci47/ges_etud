import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ges_etud/main.dart';
import 'package:ges_etud/pages/login/login_page.dart';
import 'package:ges_etud/provider/admin_provider.dart';
import 'package:ges_etud/provider/etudiant_provider.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future _combineFuture; // ← déclarer le Future
  @override
  void initState() {
    super.initState();
    final admin = Provider.of<AdminProvider>(context, listen: false);
    final etudiant = Provider.of<EtudiantProvider>(context, listen: false);
    Future futureAdmin = admin
        .getInfosAdmin(); // ← lancer la requête UNE SEULE FOIS
    Future futureEtudiants = etudiant.getDashboard();
    // await admin.getInfosAdmin();

    _combineFuture = Future.wait([futureAdmin, futureEtudiants]);
  }

  @override
  Widget build(BuildContext context) {
    final admin = Provider.of<AdminProvider>(context, listen: false);
    final etudiant = Provider.of<EtudiantProvider>(context, listen: false);

    return Scaffold(
      /*  appBar: AppBar(
        leading: Column(children: [Text("data"), Text("data")]),
        actions: [
          IconButton(
            onPressed: () async {
              await admin.logoutAdmin();
              // print("Logout");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
        backgroundColor: d_blue,
      ), */
      body: FutureBuilder(
        future: _combineFuture, // ← le Future stocké
        builder: (context, snapshot) {
          // État 1 : En attente → afficher un loader
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // État 2 : Erreur → afficher un message d'erreur
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }
          // État 3 : Données reçues → afficher les infos admin
          final adminInfos =
              admin.adminInfos; // ← maintenant les données sont là !
          final tableauDash = etudiant.tableauDashboard;
          // print(tableauDash);
          return SingleChildScrollView(
            // padding: EdgeInsets.all(20),
            child: Column(
              children: [
                _headers(
                  admin,
                  tableauDash["total_etudiants"],
                  tableauDash["inscrits_ce_mois"],
                ),
                // Text(adminInfos['first_name'] ?? ''),
                // Text(adminInfos['email'] ?? ''),
                _actions(),
                _recent(tableauDash["recents_etudiants"]),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: d_blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {},
        child: Icon(LucideIcons.plus400, size: 28, color: Colors.white),
      ),
    );
  }

  Widget _headers(AdminProvider admin, int nbreEtudiants, int mois) {
    return Container(
      // padding: EdgeInsets.all(20),
      padding: EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 50),
      // margin: EdgeInsets.only(bottom: 0),
      height: 250,
      // width: double.infinity,
      color: d_blue,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bienvenue",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${admin.adminInfos['prenom'] + " " + "${admin.adminInfos['nom']}" ?? ""}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                // padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    await admin.logoutAdmin();
                    print("Logout");
                  },
                  icon: Icon(
                    LucideIcons.logOut600,
                    size: 25,
                    color: Colors.red,
                  ),
                  /* icon: Icon(
                    Icons.logout_outlined,
                    size: 25,
                    color: Colors.red,
                  ), */
                ),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: [
              _cardHeader(nbre: nbreEtudiants, label: "Etudiants"),
              _cardHeader(nbre: 6, label: "Promotions"),
              _cardHeader(nbre: mois, label: "Ce mois"),
            ],
            // physics: NeverScrollableScrollPhysics(),
            // itemCount: 3,
            /*  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              // childAspectRatio: 1,
            ), */
          ),
        ],
      ),
    );
  }
}

Widget _cardHeader({required int nbre, required String label}) {
  return Container(
    height: 5,
    width: 5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      // shape: RoundedRectangleBorder(),
      color: Colors.white.withOpacity(0.15),
    ),
    // color: d_blue.withOpacity(0.3),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$nbre",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18),
        ),
      ],
    ),
  );
}

Widget _actions() {
  return Container(
    // padding: EdgeInsets.only(right: 40, left: 40, top: 20),
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Actions rapide",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            // Carte 1 : Ajouter
            _buildCard(
              icon: LucideIcons.userRoundPlus400,
              // icon: Icons.person_add,
              label: "Ajouter",
              color: Color(0xFFE3F2FD), // Bleu clair
              onTap: () {
                print("Clic sur Ajouter");
                // Navigator.push(...) ou action ici
              },
            ),

            // Carte 2 : Rechercher
            _buildCard(
              icon: LucideIcons.search400,
              label: "Rechercher",
              color: Color(0xFFE0F2F1), // Vert clair
              onTap: () {
                print("Clic sur Rechercher");
              },
            ),

            // Carte 3 : Exporter
            _buildCard(
              icon: Icons.upload_file,
              label: "Exporter",
              color: Color(0xFFFFF3E0), // Orange clair
              onTap: () {
                print("Clic sur Exporter");
              },
            ),

            // Carte 4 : Stats
            _buildCard(
              icon: Icons.bar_chart,
              label: "Stats",
              color: Color(0xFFF3E5F5), // Violet clair
              onTap: () {
                print("Clic sur Stats");
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCard({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        // color: Colors.black.withOpacity(0.15),
        color: Color(0xFFFFF3E0).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color, // Fond de l'icône (bleu, vert, etc.)
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

Widget _recent(List etudiants) {
  Color getStatutColor(String statut) {
    return switch (statut) {
      'actif' => Colors.green,
      'inactif' => Colors.red,
      'conge' => Colors.deepPurple,
      'diplome' => Colors.blue,
      'suspendu' => Colors.deepOrange,
      _ => Colors.transparent, // Cas par défaut (si le statut est inconnu)
    };
  }

  return Container(
    // padding: EdgeInsets.only(right: 25, left: 25, top: 20),
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Récents",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: etudiants.length,
          itemBuilder: (context, index) {
            return ListTile(
              minVerticalPadding: 20,
              horizontalTitleGap: 20,
              /* minLeadingWidth: 15,
              minTileHeight: 10, */
              contentPadding: EdgeInsets.all(-0),
              onTap: () {
                print(etudiants[index]['nom_complet']);
              },
              shape: Border(bottom: BorderSide(color: d_blue, width: 0.3)),
              titleAlignment: ListTileTitleAlignment.center,
              // isThreeLine: true,
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors
                    .primaries[Random().nextInt(Colors.primaries.length)]
                    .shade200,
                foregroundColor: d_blue,
                child: Text(
                  etudiants[index]['prenom']![0] +
                          etudiants[index]['nom']![0] ??
                      "",
                ),
              ),
              title: Text(
                etudiants[index]['nom_complet'] ?? 'nom define',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${etudiants[index]['promotion_code']} - ${etudiants[index]['filiere_nom'] ?? ""}",
                style: TextStyle(fontSize: 16),
              ),
              trailing: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: getStatutColor(
                    etudiants[index]['statut'],
                  ).withOpacity(0.5),
                ),
                child: Text(
                  etudiants[index]['statut'],

                  style: TextStyle(
                    // decoration: TextDecoration.overline,
                    // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,

                    // decoration: TextD,
                    color: getStatutColor(etudiants[index]['statut']),
                    // padd
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
