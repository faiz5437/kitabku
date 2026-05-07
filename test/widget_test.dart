import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitab_ku/main.dart';

void main() {
  testWidgets('App should render', (WidgetTester tester) async {
    await tester.pumpWidget(const KitabKuApp());
    expect(find.text('KitabKu'), findsOneWidget);
  });
}
