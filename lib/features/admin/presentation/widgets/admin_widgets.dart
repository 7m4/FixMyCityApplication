import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});
  @override
  Widget build(BuildContext context) => Container(
    color: AppColors.primary,
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
    child: const Row(children: [
      Icon(Icons.location_city, color: Colors.white, size: 27),
      SizedBox(width: 10),
      Text('FixMyCity', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
      Spacer(),
      Text('بوابة المسؤول العام', style: TextStyle(color: Colors.white70)),
    ]),
  );
}

class AdminPageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AdminPageHeader(this.title, this.subtitle, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: AppColors.navy)),
      const SizedBox(height: 4),
      Text(subtitle, style: const TextStyle(color: AppColors.text)),
    ]),
  );
}

class AdminSectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const AdminSectionCard({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white, elevation: 0,
    margin: const EdgeInsets.fromLTRB(18, 0, 18, 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: AppColors.border)),
    child: Padding(padding: const EdgeInsets.all(17), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy)),
      const SizedBox(height: 14),
      child,
    ])),
  );
}
