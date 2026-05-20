import 'package:flutter/material.dart';
import 'package:ges_etud/colors/app_theme.dart';
import 'package:ges_etud/provider/etudiant_provider.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late Future _stats;
  @override
  void initState() {
    super.initState();
    final etudiant = Provider.of<EtudiantProvider>(context, listen: false);
    _stats = etudiant.getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<EtudiantProvider>(
      context,
      listen: false,
    ).tableauDashboard["statsDash"];
    final statsPromotion = Provider.of<EtudiantProvider>(
      context,
      listen: false,
    ).tableauDashboard["statsPromotion"];
    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: FutureBuilder(
        future: _stats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }
          // final stats = snapshot.data as Map;
          print(statsPromotion);
          return CustomScrollView(
            slivers: [
              // ── Header ──
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.navy,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 12, 20, 16),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Statistiques',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Année académique 2024–2025',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Body ──
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // ── Carte total ──
                    // _StatSummaryCard(dash: dash),
                    const SizedBox(height: 16),

                    // ── Étudiants par promotion ──
                    _SectionCard(
                      icon: Icons.bar_chart_rounded,
                      title: 'Étudiants par promotion',
                      child: Column(
                        children: [
                          _BarRow(
                            label: statsPromotion[0]["promotion"],
                            value: statsPromotion[0]["total"],
                            maxValue: snapshot.data["total_etudiants"],
                            color: AppColors.navy,
                          ),
                          _BarRow(
                            label: statsPromotion[1]["promotion"],
                            value: statsPromotion[1]["total"],
                            maxValue: snapshot.data["total_etudiants"],
                            color: AppColors.navy,
                          ),
                          _BarRow(
                            label: statsPromotion[2]["promotion"],
                            value: statsPromotion[2]["total"],
                            maxValue: snapshot.data["total_etudiants"],
                            color: AppColors.navy,
                          ),
                          _BarRow(
                            label: statsPromotion[3]["promotion"],
                            value: statsPromotion[3]["total"],
                            maxValue: snapshot.data["total_etudiants"],
                            color: const Color(0xFF378ADD),
                          ),
                          _BarRow(
                            label: statsPromotion[4]["promotion"],
                            value: statsPromotion[4]["total"],
                            maxValue: snapshot.data["total_etudiants"],
                            color: const Color(0xFF378ADD),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Taux d'activité ──
                    _SectionCard(
                      icon: Icons.donut_large_rounded,
                      title: 'Taux d\'activité',
                      child: Column(
                        children: [
                          _PieRow(
                            color: AppColors.statusActive,
                            label: 'Actif',
                            count: dash["actifs"],
                            total: snapshot.data["total_etudiants"],
                          ),
                          _PieRow(
                            color: AppColors.statusLeave,
                            label: 'Congé',
                            count: dash["en_conge"],
                            total: dash["total_etudiants"],
                          ),
                          _PieRow(
                            color: AppColors.statusInactive,
                            label: 'Inactif',
                            count: dash["inactifs"],
                            total: dash["total_etudiants"],
                          ),
                          _PieRow(
                            color: AppColors.statusGraduate,
                            label: 'Diplômé',
                            count: dash["diplomes"],
                            total: dash["total_etudiants"],
                          ),
                          _PieRow(
                            color: AppColors.statusSuspended,
                            label: 'Suspendu',
                            count: dash["suspendus"],
                            total: dash["total_etudiants"],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Inscriptions par mois ──
                    /* _SectionCard(
              icon : Icons.calendar_month_rounded,
              title: 'Inscriptions par mois',
              child: _MonthlyBars(),
            ), */
                    const SizedBox(height: 80),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.navy),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _BarRow extends StatelessWidget {
  final String label;
  final int value, maxValue;
  final Color color;
  const _BarRow({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value / maxValue,
                minHeight: 10,
                backgroundColor: AppColors.borderLight,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 28,
            child: Text(
              value.toString(),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PieRow extends StatelessWidget {
  final Color color;
  final String label;
  final int count, total;
  const _PieRow({
    required this.color,
    required this.label,
    required this.count,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? (count / total * 100).toInt() : 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: total > 0 ? count / total : 0,
                minHeight: 8,
                backgroundColor: AppColors.borderLight,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$pct%',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
