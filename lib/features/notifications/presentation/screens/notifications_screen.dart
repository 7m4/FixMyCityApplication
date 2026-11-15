import 'package:flutter/material.dart';
import '../../../../core/testing/test_data_loader.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}
class _NotificationsScreenState extends State<NotificationsScreen> {
  late Future<List<Map<String, dynamic>>> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = TestDataLoader.loadList('notifications.json');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('الإشعارات')),
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: _notifications,
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Center(child: Text('تعذّر تحميل الإشعارات.'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        final items = snapshot.data!;
        final unread = items.where((item) => item['isRead'] != true).length;
        if (items.isEmpty) return const Center(child: Text('لا توجد إشعارات حالياً.'));
        return ListView(padding: const EdgeInsets.all(20), children: [
          AppCard(child: Text('لديك $unread إشعار غير مقروء', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
          const SizedBox(height: 14),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppCard(child: InkWell(
              onTap: () => _showNotification(context, item),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(item['isRead'] == true ? Icons.notifications_none : Icons.notifications_active, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(item['title']?.toString() ?? '', style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(item['message']?.toString() ?? '', style: const TextStyle(color: AppColors.text, height: 1.5)),
                  const SizedBox(height: 6),
                  Text(item['date']?.toString() ?? '', style: const TextStyle(color: AppColors.hint, fontSize: 11)),
                ])),
                if (item['isRead'] != true) const Icon(Icons.circle, size: 8, color: AppColors.primary),
              ]),
            )),
          )),
        ]);
      },
    ),
  );

  void _showNotification(BuildContext context, Map<String, dynamic> item) {
    setState(() => item['isRead'] = true);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Directionality(textDirection: TextDirection.rtl, child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item['title']?.toString() ?? '', style: const TextStyle(color: AppColors.navy, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(item['message']?.toString() ?? '', style: const TextStyle(color: AppColors.text, height: 1.7)),
          const SizedBox(height: 16),
          Text('رقم البلاغ: ${item['reportId'] ?? '-'}', textDirection: TextDirection.ltr),
        ]),
      )),
    );
  }
}