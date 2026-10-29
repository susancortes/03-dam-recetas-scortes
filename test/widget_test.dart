import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recetas_app/main.dart';

void main() {
  testWidgets('La app muestra la pantalla de bienvenida', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Recetas App'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
