import 'package:flutter/material.dart';
import 'services/progress_service.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final progressService = ProgressService();
  runApp(DevInterviewPrepApp(progressService: progressService));
}

class DevInterviewPrepApp extends StatelessWidget {
  final ProgressService progressService;

  const DevInterviewPrepApp({super.key, required this.progressService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevInterview Prep',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: HomeScreen(progressService: progressService),
    );
  }
}
