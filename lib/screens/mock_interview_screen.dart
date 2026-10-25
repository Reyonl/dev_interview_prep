import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/question_bank.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';

class MockInterviewScreen extends StatefulWidget {
  final ProgressService progressService;

  const MockInterviewScreen({super.key, required this.progressService});

  @override
  State<MockInterviewScreen> createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  static const int questionDurationSeconds = 60;
  static const int totalQuestionsInMock = 10;

  final TtsService _ttsService = TtsService();

  late List<Question> _sessionQuestions;
  int _currentIndex = 0;
  int? _selectedOption;
  bool _hasSubmitted = false;

  // Timer states
  Timer? _questionTimer;
  int _remainingSeconds = questionDurationSeconds;
  bool _isAutoSpeakEnabled = true;

  // Session stats
  final Map<int, int> _sessionAnswers = {}; // index -> selectedOption
  final Map<int, bool> _sessionResults = {}; // index -> isCorrect
  int _totalElapsedSeconds = 0;
  Timer? _totalElapsedTimer;

  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _initSession();
  }

  void _initSession() {
    // Ambil acak hingga totalQuestionsInMock dari questionBank
    final shuffled = List<Question>.from(questionBank)..shuffle();
    _sessionQuestions = shuffled.take(totalQuestionsInMock).toList();

    _currentIndex = 0;
    _selectedOption = null;
    _hasSubmitted = false;
    _sessionAnswers.clear();
    _sessionResults.clear();
    _totalElapsedSeconds = 0;
    _isFinished = false;

    _startTotalTimer();
    _startQuestionTimer();

    // Auto speak question jika diaktifkan
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isAutoSpeakEnabled && _sessionQuestions.isNotEmpty) {
        _speakCurrentQuestion();
      }
    });
  }

  void _startTotalTimer() {
    _totalElapsedTimer?.cancel();
    _totalElapsedTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isFinished && mounted) {
        setState(() {
          _totalElapsedSeconds++;
        });
      }
    });
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();
    _remainingSeconds = questionDurationSeconds;

    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        // Waktu habis!
        timer.cancel();
        _handleTimeUp();
      }
    });
  }

  void _handleTimeUp() {
    if (_hasSubmitted || _isFinished) return;

    setState(() {
      _hasSubmitted = true;
      _selectedOption = -1; // -1 = Waktu habis tanpa memilih
      _sessionAnswers[_currentIndex] = -1;
      _sessionResults[_currentIndex] = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('⏱️ Waktu 60 detik habis untuk soal ini!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _speakCurrentQuestion() {
    if (_sessionQuestions.isEmpty) return;
    final q = _sessionQuestions[_currentIndex];
    _ttsService.speak(
      text: '${q.category.title}. Pertanyaan: ${q.question}',
      speechId: 'q_${q.id}',
    );
  }

  void _handleSelectOption(int index) {
    if (_hasSubmitted) return;

    _questionTimer?.cancel();

    final currentQ = _sessionQuestions[_currentIndex];
    final isCorrect = index == currentQ.correctOptionIndex;

    setState(() {
      _selectedOption = index;
      _hasSubmitted = true;
      _sessionAnswers[_currentIndex] = index;
      _sessionResults[_currentIndex] = isCorrect;
    });

    // Simpan progres ke ProgressService
    widget.progressService.recordAnswer(currentQ.id, index);
  }

  void _goToNext() {
    _ttsService.stop();

    if (_currentIndex < _sessionQuestions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _hasSubmitted = false;
      });
      _startQuestionTimer();

      if (_isAutoSpeakEnabled) {
        _speakCurrentQuestion();
      }
    } else {
      // Sesi selesai
      _questionTimer?.cancel();
      _totalElapsedTimer?.cancel();
      setState(() {
        _isFinished = true;
      });
    }
  }

  @override
  void dispose() {
    _questionTimer?.cancel();
    _totalElapsedTimer?.cancel();
    _ttsService.stop();
    super.dispose();
  }

  Color _getTimerColor() {
    if (_remainingSeconds > 30) return AppTheme.success;
    if (_remainingSeconds > 15) return Colors.amber;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    if (_sessionQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Mock Interview')),
        body: const Center(child: Text('Bank soal belum tersedia.')),
      );
    }

    if (_isFinished) {
      return _buildFinishedScreen();
    }

    final q = _sessionQuestions[_currentIndex];
    final timerFraction = _remainingSeconds / questionDurationSeconds;
    final isCorrect = _selectedOption == q.correctOptionIndex;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Simulasi Ujian Wawancara',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Soal ${_currentIndex + 1} dari ${_sessionQuestions.length} · Total: ${_totalElapsedSeconds}s',
              style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
            ),
          ],
        ),
        actions: [
          // Audio Speaker Toggle
          ListenableBuilder(
            listenable: _ttsService,
            builder: (context, _) {
              final isSpeaking = _ttsService.currentSpeakingId == 'q_${q.id}' && _ttsService.isPlaying;
              return IconButton(
                tooltip: isSpeaking ? 'Hentikan Suara' : 'Dengarkan Pertanyaan',
                icon: Icon(
                  isSpeaking ? Icons.volume_off : Icons.volume_up,
                  color: isSpeaking ? AppTheme.accent : AppTheme.textSecondary,
                ),
                onPressed: _speakCurrentQuestion,
              );
            },
          ),
          // Auto-TTS setting toggle
          IconButton(
            tooltip: _isAutoSpeakEnabled ? 'Auto-Voice: Aktif' : 'Auto-Voice: Nonaktif',
            icon: Icon(
              _isAutoSpeakEnabled ? Icons.record_voice_over : Icons.voice_over_off,
              color: _isAutoSpeakEnabled ? AppTheme.accent : AppTheme.textMuted,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _isAutoSpeakEnabled = !_isAutoSpeakEnabled;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isAutoSpeakEnabled
                        ? 'Suara pembacaan otomatis: AKTIF'
                        : 'Suara pembacaan otomatis: NONAKTIF',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: timerFraction,
            backgroundColor: AppTheme.surfaceElevated,
            valueColor: AlwaysStoppedAnimation<Color>(_getTimerColor()),
            minHeight: 5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── COUNTDOWN & CATEGORY BAR ──────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _getTimerColor().withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _getTimerColor().withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.timer, color: _getTimerColor(), size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$_remainingSeconds dtk',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _getTimerColor(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Spacer(),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        q.category.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ─── QUESTION CARD ─────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(Icons.psychology, color: AppTheme.accent, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          q.question,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.cardBorder),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, size: 14, color: AppTheme.textMuted),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Tujuan Penguji: ${q.whyAsked}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ─── PILIHAN JAWABAN ───────────────────────────────────────────
            const Text(
              'Pilih Respons Terbaikmu:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 10),

            ...List.generate(q.options.length, (index) {
              final optionText = q.options[index];
              return _buildOptionTile(
                index: index,
                text: optionText,
                correctIndex: q.correctOptionIndex,
              );
            }),

            const SizedBox(height: 18),

            // ─── INSTANT CORRECTION & TIPS ──────────────────────────────────
            if (_hasSubmitted) ...[
              _buildFeedbackCard(q, isCorrect),
              const SizedBox(height: 20),
            ],

            // ─── ACTION BUTTON ─────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _hasSubmitted ? AppTheme.accent : AppTheme.surfaceElevated,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _hasSubmitted ? _goToNext : null,
                icon: Icon(
                  _currentIndex < _sessionQuestions.length - 1
                      ? Icons.arrow_forward
                      : Icons.assessment,
                  size: 18,
                ),
                label: Text(
                  _currentIndex < _sessionQuestions.length - 1
                      ? 'Lanjut ke Soal Berikutnya'
                      : 'Lihat Hasil Evaluasi Simulasi',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required int index,
    required String text,
    required int correctIndex,
  }) {
    final isSelected = _selectedOption == index;
    final isCorrectOption = index == correctIndex;

    Color borderColor = AppTheme.cardBorder;
    Color bgColor = AppTheme.surface;
    Widget? trailingIcon;

    if (_hasSubmitted) {
      if (isCorrectOption) {
        borderColor = AppTheme.success;
        bgColor = AppTheme.success.withValues(alpha: 0.12);
        trailingIcon = const Icon(Icons.check_circle, color: AppTheme.success, size: 20);
      } else if (isSelected) {
        borderColor = AppTheme.error;
        bgColor = AppTheme.error.withValues(alpha: 0.12);
        trailingIcon = const Icon(Icons.cancel, color: AppTheme.error, size: 20);
      }
    } else if (isSelected) {
      borderColor = AppTheme.accent;
      bgColor = AppTheme.accent.withValues(alpha: 0.08);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: _hasSubmitted ? null : () => _handleSelectOption(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.accent : AppTheme.surfaceElevated,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                trailingIcon,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackCard(Question q, bool isCorrect) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppTheme.success.withValues(alpha: 0.10)
            : AppTheme.error.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCorrect ? AppTheme.success : AppTheme.error,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.error,
                color: isCorrect ? AppTheme.success : AppTheme.error,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect ? 'Jawaban Tepat! Standar Senior Engineer' : 'Jawaban Kurang Tepat / Waktu Habis',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? AppTheme.success : AppTheme.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Naskah Ideal di Hadapan Interviewer:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            q.idealAnswer,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.tips_and_updates, size: 14, color: AppTheme.accent),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Tips Senior: ${q.seniorTip}',
                    style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── FINAL RESULT DASHBOARD ──────────────────────────────────────────────
  Widget _buildFinishedScreen() {
    final total = _sessionQuestions.length;
    int correctCount = 0;
    for (final isCorr in _sessionResults.values) {
      if (isCorr) correctCount++;
    }

    final percentage = ((correctCount / total) * 100).round();
    final isPassed = percentage >= 70;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Hasil Simulasi'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Score Badge
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    isPassed
                        ? AppTheme.success.withValues(alpha: 0.3)
                        : AppTheme.error.withValues(alpha: 0.3),
                    AppTheme.surface,
                  ],
                ),
                border: Border.all(
                  color: isPassed ? AppTheme.success : AppTheme.error,
                  width: 3,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isPassed ? AppTheme.success : AppTheme.error,
                    ),
                  ),
                  Text(
                    '$correctCount / $total Soal',
                    style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isPassed ? '🎉 SIAP TEMPUR WAWANCARA TEKNIS!' : '💪 PERLU SEDIKIT POLESAN LAGI',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isPassed ? AppTheme.success : Colors.amber,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isPassed
                  ? 'Pemahaman logika, konsep OOP/Laravel, keamanan, dan arsitekturmu sudah sangat solid di level Software Engineer.'
                  : 'Pelajari kembali pembahasan dan tips senior pada materi yang belum kamu kuasai agar makin percaya diri.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 24),

            // Statistics Row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.cardBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Durasi', '${_totalElapsedSeconds}s', Icons.speed),
                  _buildStatItem('Benar', '$correctCount', Icons.check, color: AppTheme.success),
                  _buildStatItem('Salah/Timeout', '${total - correctCount}', Icons.close, color: AppTheme.error),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Navigation Buttons
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(() {
                    _initSession();
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Ulangi Simulasi (Soal Acak Baru)', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.textSecondary,
                  side: const BorderSide(color: AppTheme.cardBorder),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.dashboard),
                label: const Text('Kembali ke Dashboard Utama'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, {Color? color}) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color ?? AppTheme.accent),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color ?? AppTheme.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppTheme.textMuted),
        ),
      ],
    );
  }
}
