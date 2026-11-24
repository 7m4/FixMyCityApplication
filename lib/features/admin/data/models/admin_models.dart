class Department {
  String name;
  String description;
  String institution;
  String manager;
  List<String> types;
  int reports;
  int solved;
  bool active;

  Department({
    required this.name,
    required this.description,
    required this.institution,
    required this.manager,
    required this.types,
    this.reports = 0,
    this.solved = 0,
    this.active = true,
  });
}

class ReportType {
  final String name;
  final String code;
  final String description;

  const ReportType(this.name, this.code, this.description);
}

class CityReport {
  final String id;
  final String title;
  final String department;
  final String status;
  final String location;
  final String date;

  const CityReport(
    this.id, this.title, this.department, this.status, this.location, this.date,
  );
}

List<Department> sampleDepartments() => [
  Department(name: 'صيانة الطرق', description: 'معالجة الحفر وأضرار الطرق والأرصفة وصيانتها.', institution: 'بلدية الزرقاء', manager: 'أحمد العلي', types: ['حفر في الطرق', 'تلف الأرصفة', 'تضرر حواجز الطرق'], reports: 186, solved: 146),
  Department(name: 'النظافة العامة', description: 'متابعة النظافة وإزالة النفايات من الأماكن العامة.', institution: 'بلدية الزرقاء', manager: 'ريم حسن', types: ['تراكم النفايات', 'حاويات تالفة'], reports: 124, solved: 103),
  Department(name: 'الإنارة العامة', description: 'صيانة أعمدة الإنارة ومتابعة أعطال الإضاءة.', institution: 'بلدية الزرقاء', manager: 'عمر محمود', types: ['تعطل الإنارة', 'تلف أعمدة الإنارة'], reports: 98, solved: 76),
  Department(name: 'المياه والصرف الصحي', description: 'متابعة تسربات المياه ومشكلات الصرف الصحي.', institution: 'مؤسسة خدمات المياه', manager: 'ليلى خالد', types: ['تسرب مياه', 'انسداد الصرف الصحي', 'كسر أنبوب'], reports: 66, solved: 47),
];

List<ReportType> sampleReportTypes() => const [
  ReportType('حفر في الطرق', 'ROAD-POTHOLE', 'وجود حفرة أو هبوط في الطريق.'),
  ReportType('تراكم النفايات', 'WASTE-PILE', 'تراكم النفايات في الأماكن العامة.'),
  ReportType('تعطل الإنارة', 'LIGHT-FAIL', 'تعطل مصباح أو عمود إنارة.'),
  ReportType('تلف إشارات المرور', 'TRAFFIC-SIGN', 'إشارة مرور تالفة أو غير واضحة.'),
];

List<CityReport> sampleCityReports() => const [
  CityReport('FMC-2026-1042', 'حفرة في الطريق الرئيسي', 'صيانة الطرق', 'بانتظار الموافقة', 'شارع الملك عبدالله، الزرقاء', '09/11/2026'),
  CityReport('FMC-2026-1038', 'تراكم النفايات', 'النظافة العامة', 'قيد التنفيذ', 'شارع الجيش، الزرقاء', '08/11/2026'),
  CityReport('FMC-2026-1021', 'تعطل الإنارة', 'الإنارة العامة', 'تم الحل', 'حي الأمير حسن، الزرقاء', '06/11/2026'),
  CityReport('FMC-2026-1017', 'تسرب مياه', 'المياه والصرف الصحي', 'قيد التنفيذ', 'شارع السعادة، الزرقاء', '05/11/2026'),
  CityReport('FMC-2026-1009', 'تلف الأرصفة', 'صيانة الطرق', 'تم الحل', 'شارع الملك حسين، الزرقاء', '03/11/2026'),
  CityReport('FMC-2026-1007', 'تراكم النفايات', 'النظافة العامة', 'قيد التنفيذ', 'شارع السعادة، الزرقاء', '02/11/2026'),
  CityReport('FMC-2026-1005', 'تعطل الإنارة', 'الإنارة العامة', 'بانتظار الموافقة', 'شارع الملك طلال، الزرقاء', '01/11/2026'),
  CityReport('FMC-2026-1002', 'تسرب مياه', 'المياه والصرف الصحي', 'قيد التنفيذ', 'حي معصوم، الزرقاء', '31/10/2026'),
];
