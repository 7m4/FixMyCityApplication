import 'package:flutter_test/flutter_test.dart';
import 'package:fix_my_city_application/main.dart';

void main() {
  testWidgets('app opens on the FixMyCity splash screen', (tester) async {
    await tester.pumpWidget(const FixMyCityApp());

    expect(find.text('FixMyCity'), findsOneWidget);
    expect(find.text('معًا لحيّ أفضل'), findsOneWidget);
  });
}
