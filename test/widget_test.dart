import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_menu_page/main.dart';

void main() {
  testWidgets('menu selection shows only one information panel', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Information'), findsNothing);

    await tester.tap(find.text('Menu 1'));
    await tester.pumpAndSettle();

    expect(find.text('Information'), findsOneWidget);
    expect(find.text('Name 1'), findsOneWidget);
    expect(find.text('Address 1'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Menu 2'), 160);
    await tester.tap(find.text('Menu 2'));
    await tester.pumpAndSettle();

    expect(find.text('Information'), findsOneWidget);
    expect(find.text('Name 1'), findsNothing);
    expect(find.text('Address 1'), findsNothing);
    expect(find.text('Name 2'), findsOneWidget);
    expect(find.text('Address 2'), findsOneWidget);
  });

  testWidgets('main layout renders header, summary cards, and fab', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Main Page'), findsOneWidget);
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Add'), findsOneWidget);
    expect(find.text('C1'), findsOneWidget);
    expect(find.text('C2'), findsOneWidget);
    expect(find.text('C3'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
