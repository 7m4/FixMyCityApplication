import 'package:flutter/material.dart';

class DemoReport {
  final String number;
  final String title;
  final String category;
  final String department;
  final String location;
  final String date;
  final String status;
  final String description;

  const DemoReport({
    required this.number,
    required this.title,
    required this.category,
    required this.department,
    required this.location,
    required this.date,
    required this.status,
    required this.description,
  });
}

/// بيانات تجريبية للعرض فقط. لا يوجد اتصال بقاعدة بيانات أو API.
class DemoData {
  DemoData._();

  static const userName = 'أحمد';
  static const totalReports = 24;
  static const activeReports = 8;
  static const completedReports = 16;
  static const trackingNumber = 'FMC-2026-1042';

  static const departments = [
    'دائرة الأشغال العامة',
    'دائرة النظافة والبيئة',
    'دائرة الكهرباء والإنارة',
    'دائرة المياه والصرف الصحي',
  ];

  static const categories = [
    'حفرة في الشارع',
    'تراكم النفايات',
    'انقطاع الإنارة',
    'تلف الأرصفة',
    'تسرب مياه',
    'مشكلة أخرى',
  ];

  static const reports = <DemoReport>[
    DemoReport(
      number: 'FMC-2026-1042',
      title: 'حفرة في الشارع الرئيسي',
      category: 'حفرة في الشارع',
      department: 'دائرة الأشغال العامة',
      location: 'شارع الجامعة، الزرقاء',
      date: '٩ نوفمبر ٢٠٢٦',
      status: 'قيد المراجعة',
      description: 'توجد حفرة كبيرة بالقرب من التقاطع وتحتاج إلى صيانة.',
    ),
    DemoReport(
      number: 'FMC-2026-1038',
      title: 'تراكم النفايات',
      category: 'تراكم النفايات',
      department: 'دائرة النظافة والبيئة',
      location: 'حي الأمير حسن، الزرقاء',
      date: '٧ نوفمبر ٢٠٢٦',
      status: 'قيد التنفيذ',
      description: 'تراكم النفايات بجانب الحاويات منذ عدة أيام.',
    ),
    DemoReport(
      number: 'FMC-2026-1021',
      title: 'إنارة شارع معطلة',
      category: 'انقطاع الإنارة',
      department: 'دائرة الكهرباء والإنارة',
      location: 'شارع الجيش، الزرقاء',
      date: '٢ نوفمبر ٢٠٢٦',
      status: 'تم الحل',
      description: 'عدد من أعمدة الإنارة لا تعمل في الشارع.',
    ),
  ];

  static const notifications = [
    ('تم تحديث حالة البلاغ', 'تم تحويل البلاغ FMC-2026-1042 إلى قيد المراجعة', 'منذ ١٥ دقيقة'),
    ('تم استلام بلاغك', 'تم استلام بلاغك وسيتم مراجعته من القسم المختص', 'أمس'),
    ('تم إغلاق البلاغ', 'تم حل المشكلة وإغلاق البلاغ FMC-2026-1021', 'قبل ٣ أيام'),
  ];

  static const statusHistory = [
    ('تم إرسال البلاغ', '٩ نوفمبر ٢٠٢٦ · ١:٢٠ م', true),
    ('تم استلام البلاغ', '٩ نوفمبر ٢٠٢٦ · ١:٢٢ م', true),
    ('قيد المراجعة', '٩ نوفمبر ٢٠٢٦ · ١:٤٥ م', true),
    ('إسناد البلاغ إلى القسم المختص', 'بانتظار التحديث', false),
    ('بدء التنفيذ', 'بانتظار التحديث', false),
    ('تم الحل', 'بانتظار التحديث', false),
  ];
}
