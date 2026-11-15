import 'dart:convert';

import 'package:flutter/services.dart';

/// Loads local JSON files used while building and checking the app screens.
class TestDataLoader {
  TestDataLoader._();

  /// Reads a JSON file from the test_data folder and returns a list of maps.
  ///
  /// Example:
  /// final reports = await TestDataLoader.loadList('reports.json');
  static Future<List<Map<String, dynamic>>> loadList(String fileName) async {
    final jsonText = await rootBundle.loadString('test_data/$fileName');
    final decodedData = jsonDecode(jsonText);

    if (decodedData is! List) {
      throw const FormatException('The test data file must contain a JSON list.');
    }

    return decodedData.map((item) {
      if (item is! Map) {
        throw const FormatException('Every item in the JSON list must be an object.');
      }

      return Map<String, dynamic>.from(item);
    }).toList();
  }
}
