import 'package:flutter/material.dart';
import 'package:ges_etud/colors/app_theme.dart';

/* class StatusBadge extends StatelessWidget {
  final String status;
  final bool dot;
 
  const StatusBadge({super.key, required this.status, this.dot = false});
 
  @override
  Widget build(BuildContext context) {
    final (color, label) = _statusInfo(status);
    if (dot) {
      return Container(
        width: 10, height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 6, height: 6,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(label, style: TextStyle(
          fontSize: 11, fontWeight: FontWeight.w500, color: color,
        )),
      ]),
    );
  }
 
  (Color, String) _statusInfo(String s) => switch (s) {
    "actif"     => (AppColors.statusActive,    'Actif'),
    "conge"     => (AppColors.statusLeave,     'Congé'),
    "inactif"   => (AppColors.statusInactive,  'Inactif'),
    "diplome"   => (AppColors.statusGraduate,  'Diplômé'),
    "suspendu"  => (AppColors.statusSuspended, 'Suspendu'),
  };
} */

class StudentAvatar extends StatelessWidget {
  final Map etudiant;
  final double size;

  const StudentAvatar({super.key, required this.etudiant, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final idx = etudiant['id'] != null ? etudiant['id'] % 6 : 0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.avatarBg[idx],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          etudiant['prenom']![0] + etudiant['nom']![0],
          style: TextStyle(
            fontSize: size * 0.35,
            fontWeight: FontWeight.w600,
            color: AppColors.avatarFg[idx],
          ),
        ),
      ),
    );
  }
}

// ─── Info Row (detail card) ───────────────────────────────────
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.navyLight),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 17,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Card ─────────────────────────────────────────────
class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SectionCard({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            children: children.asMap().entries.map((entry) {
              final last = entry.key == children.length - 1;
              return Column(
                children: [
                  entry.value,
                  if (!last) const Divider(height: 1, indent: 14),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
