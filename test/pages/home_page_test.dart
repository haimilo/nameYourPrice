import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_sample_flutter_app/pages/home_page.dart';

void main() {
  group('Home page', () {
    testWidgets('Change product name after each click',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));
      expect(find.text(products[0].name), findsOneWidget);

      await tester.tap(find.text('Check'));
      expect(find.text(products[1].name), findsOneWidget);
      await tester.tap(find.text('Check'));
      expect(find.text(products[2].name), findsOneWidget);
    });
  });
}
