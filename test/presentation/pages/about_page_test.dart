import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('About Page Widget Tests', () {
    testWidgets('About Page Widgets Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AboutPage(),
        ),
      );

      expect(
          find.text(
              'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.'),
          findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
