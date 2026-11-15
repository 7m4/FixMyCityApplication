/// In-memory records created during this app session.
class LocalReportStore {
  LocalReportStore._();

  static final List<Map<String, dynamic>> _reports = [];

  static List<Map<String, dynamic>> get reports => List.unmodifiable(_reports);

  static void add(Map<String, dynamic> report) {
    _reports.insert(0, Map<String, dynamic>.from(report));
  }
}