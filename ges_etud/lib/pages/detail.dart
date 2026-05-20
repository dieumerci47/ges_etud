import 'package:flutter/material.dart';
import 'package:ges_etud/colors/app_theme.dart';
import 'package:ges_etud/provider/etudiant_provider.dart';
import 'package:ges_etud/widget/widget.dart';
import 'package:provider/provider.dart';
// import 'package:ges_etud/';

class DetailPage extends StatefulWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
      backgroundColor: AppColors.background,
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
          Map s = snapshot.data;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.navy,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 20,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Retour à la liste',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              StudentAvatar(etudiant: s, size: 60),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      s["nom_complet"],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '#${s["matricule"]} · ${s["promotion_code"]} ${s["filiere_nom"]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    // StatusBadge(status: s.statut),
                                    _statutsEtudiant(s),
                                    const SizedBox(height: 16),
                                    // _bouttonInfos(label: "Modidier", icon: Icons)
                                    Row(
                                      children: [
                                        _bouttonInfos(
                                          icon: Icons.edit_rounded,
                                          label: 'Modifier',
                                          // onTap: () => context.go('/students/${s.id}/edit'),
                                        ),
                                        const SizedBox(width: 8),
                                        _bouttonInfos(
                                          icon: Icons.delete_outline_rounded,
                                          label: 'Supprimer',
                                          // onTap: () => _confirmDelete(context, s),
                                        ),
                                        const SizedBox(width: 8),
                                        _bouttonInfos(
                                          icon: Icons.share_rounded,
                                          label: 'Partager',
                                          // onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //Body
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Ionfos personnelles
                    SectionCard(
                      title: "Informations Personnelles",
                      children: [
                        InfoRow(
                          icon: Icons.calendar_today_rounded,
                          label: 'Naissance',
                          value: s["date_naissance"],
                          // value: formatDate(s.dateNaissance),
                        ),
                        InfoRow(
                          icon: Icons.location_on_outlined,
                          label: 'Ville',
                          value: s["ville"] ?? '—',
                        ),
                        InfoRow(
                          icon: Icons.phone_outlined,
                          label: 'Téléphone',
                          value: s["telephone"] ?? '—',
                        ),
                        InfoRow(
                          icon: Icons.mail_outline_rounded,
                          label: 'Email',
                          value: s["email"],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Infos Scolarité
                    SectionCard(
                      title: "Scolarité",
                      children: [
                        InfoRow(
                          icon: Icons.account_balance_outlined,
                          label: 'Faculté',
                          value: s["faculte_nom"],
                        ),
                        InfoRow(
                          icon: Icons.book_outlined,
                          label: 'Filière',
                          value: s["filiere_nom"],
                        ),
                        InfoRow(
                          icon: Icons.stairs_rounded,
                          label: 'Promotion',
                          value: s["promotion_libelle"],
                        ),
                        InfoRow(
                          icon: Icons.event_note_rounded,
                          label: 'Inscription',
                          value: s["date_inscription"],
                          // value: formatMonthYear(s.dateInscription),
                        ),
                        InfoRow(
                          icon: Icons.event_available_rounded,
                          label: 'Fin prévue',
                          value: s["date_fin_prevue"],
                          // value: formatMonthYear(s.dateFinPrevue),
                        ),
                        //Progression row
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.trending_up_rounded,
                                        size: 16,
                                        color: AppColors.textTertiary,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Progression',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${s["semestres_valides"]}/${s["semestres_total"]} sem.',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  // value: 0.5,
                                  value:
                                      s["semestres_valides"] /
                                      s["semestres_total"],
                                  minHeight: 6,
                                  backgroundColor: AppColors.borderLight,
                                  color: AppColors.navy,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                // "hy",
                                '${(s["semestres_valides"] / s["semestres_total"] * 100).toInt()}% du cursus validé',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _statutsEtudiant(Map etudiant) {
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: getStatutColor(etudiant["statut"]).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: getStatutColor(etudiant["statut"]),
              shape: BoxShape.circle,
            ),
          ),
          Text(
            etudiant["statut"],
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: getStatutColor(etudiant["statut"]),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _bouttonInfos({required String label, required IconData icon}) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        print(label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: label != "Supprimer" ? Colors.white : Colors.red,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: label != "Supprimer" ? Colors.white : Colors.red,
              ),
            ),
          ],
        ),
      ),
    ),
  )
  /* TextButton(
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
    ) */
  ;
  // );
}
