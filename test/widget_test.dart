import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dev_interview_prep/main.dart';
import 'package:dev_interview_prep/services/progress_service.dart';
import 'package:dev_interview_prep/screens/mock_interview_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DevInterviewPrepApp memuat HomeScreen, Mock Exam Banner, dan Kategori Baru', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final service = ProgressService();

    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(DevInterviewPrepApp(progressService: service));
    await tester.pumpAndSettle();

    expect(find.text('DevInterview Prep'), findsOneWidget);
    expect(find.text('Simulasi Ujian Wawancara (Mock Exam)'), findsOneWidget);
    expect(find.text('Mulai Simulasi Wawancara ⏱️'), findsOneWidget);
    expect(find.text('Simulasi Tanya Jawab'), findsOneWidget);
    expect(find.text('System Design & Scale'), findsOneWidget);
    expect(find.text('Web & API Security'), findsOneWidget);
    expect(find.text('Live Coding & Pseudocode Lab'), findsOneWidget);
  });

  testWidgets('MockInterviewScreen dapat dibuka dan menampilkan timer & tombol audio', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final service = ProgressService();

    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: MockInterviewScreen(progressService: service),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Simulasi Ujian Wawancara'), findsOneWidget);
    expect(find.byIcon(Icons.timer), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.byType(IconButton), findsWidgets);
  });
}
