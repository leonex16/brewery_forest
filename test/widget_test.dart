import 'package:brewery_forest/app/application.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const Application());
    await tester.pumpAndSettle();
  });
}
