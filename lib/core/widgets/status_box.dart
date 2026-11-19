import 'package:flutter/widgets.dart';

enum Status { 
  solved,
  inProgress, 
  rejected,
  pending,
  approved,
  unknown
}
Status getStatusFromString(String statusString) {
  switch (statusString.toLowerCase()) {
    case 'تم الحل':
      return Status.solved;
    case 'قيد التنفيذ':
      return Status.inProgress;
    case 'مرفوض':
      return Status.rejected;
    case 'قيد التنفيذ':
      return Status.pending;
    case 'تم التأكيد':
      return Status.approved;
    default:
      return Status.unknown;
  }
}
Widget StatusBox({required String textStatus}) {
  Status status = getStatusFromString(textStatus);
  var bgColor;
  var textColor; // Default to white text
  var text;
  if (status == Status.solved) {
    bgColor = const Color.fromARGB(23, 36, 115, 72); // Green
    textColor = const Color(0xFF247348);
    text = 'تم الحل';
  } else if (status == Status.inProgress || status == Status.pending) {
    bgColor = const Color(0xFF926313); // Amber
    textColor = const Color(0x17926413);
    text = 'قيد التنفيذ';
  } else if (status == Status.rejected) {
    bgColor = const Color(0x17B43F3B); // Grey
    textColor = const Color(0xFFB43F3B);
    text = 'مرفوض';
  } else if (status == Status.approved) {
    bgColor = const Color(0xFF246273); // Green
    textColor = const Color(0x17246273);
    text = 'تم التأكيد';
  } else {
    bgColor = const Color(0x179E9E9E); // Grey for unknown status
    textColor = const Color(0xFF9E9E9E);
    text = 'غير معروف';
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    ),
    child: Text(
      text,
      style: TextStyle(color: textColor),
    ),
  );
}
