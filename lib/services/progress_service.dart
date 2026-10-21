import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question.dart';
import '../data/question_bank.dart';
import '../data/task_bank.dart';

class ProgressService extends ChangeNotifier {
  static const String _keyAnswers = 'user_quiz_answers';
  static const String _keyTasks = 'user_completed_tasks';

  final Map<String, int> _userAnswers = {}; // questionId -> selectedOptionIndex
  final Set<String> _completedTaskIds = {};

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Map<String, int> get userAnswers => Map.unmodifiable(_userAnswers);
  Set<String> get completedTaskIds => Set.unmodifiable(_completedTaskIds);

  ProgressService() {
    loadProgress();
  }

  Future<void> loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final answersJson = prefs.getString(_keyAnswers);
      if (answersJson != null) {
        final decoded = jsonDecode(answersJson) as Map<String, dynamic>;
        _userAnswers.clear();
        decoded.forEach((key, value) {
          if (value is int) {
            _userAnswers[key] = value;
          }
        });
      }

      final tasksList = prefs.getStringList(_keyTasks);
      if (tasksList != null) {
        _completedTaskIds.clear();
        _completedTaskIds.addAll(tasksList);
      }
    } catch (e) {
      debugPrint('Error loading progress: $e');
    } finally {
      _isLoaded = true;
      notifyListeners();
    }
  }

  Future<void> recordAnswer(String questionId, int selectedIndex) async {
    _userAnswers[questionId] = selectedIndex;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyAnswers, jsonEncode(_userAnswers));
    } catch (e) {
      debugPrint('Error saving answer: $e');
    }
  }

  Future<void> recordTaskCompleted(String taskId) async {
    _completedTaskIds.add(taskId);
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_keyTasks, _completedTaskIds.toList());
    } catch (e) {
      debugPrint('Error saving task: $e');
    }
  }

  Future<void> resetAll() async {
    _userAnswers.clear();
    _completedTaskIds.clear();
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyAnswers);
      await prefs.remove(_keyTasks);
    } catch (e) {
      debugPrint('Error resetting progress: $e');
    }
  }

  /// Menghitung persentase kesiapan wawancara (0 - 100)
  int calculateOverallReadiness() {
    int totalPoints = 0;
    int maxPoints = (questionBank.length * 10) + (taskBank.length * 20);

    if (maxPoints == 0) return 0;

    for (final q in questionBank) {
      final userAns = _userAnswers[q.id];
      if (userAns != null && userAns == q.correctOptionIndex) {
        totalPoints += 10;
      }
    }

    for (final _ in _completedTaskIds) {
      totalPoints += 20;
    }

    final percentage = (totalPoints / maxPoints) * 100;
    return percentage.clamp(0, 100).round();
  }

  /// Menghitung persentase skor per kategori
  int calculateCategoryScore(QuestionCategory cat) {
    final questions = questionBank.where((q) => q.category == cat).toList();
    if (questions.isEmpty) return 0;

    int correct = 0;
    for (final q in questions) {
      final userAns = _userAnswers[q.id];
      if (userAns != null && userAns == q.correctOptionIndex) {
        correct++;
      }
    }

    return ((correct / questions.length) * 100).round();
  }
}
