import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/question_bank.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatefulWidget {
  final QuestionCategory category;
  final ProgressService progressService;

  const QuizScreen({
    super.key,
    required this.category,
    required this.progressService,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final TtsService _ttsService = TtsService();

  late List<Question> _questions;
  int _currentIndex = 0;
  int? _selectedOption;
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    _questions = questionBank
        .where((q) => q.category == widget.category)
        .toList();

    _loadExistingAnswer();
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }

  void _loadExistingAnswer() {
    if (_questions.isNotEmpty) {
      final currentQ = _questions[_currentIndex];
      final savedAnswer = widget.progressService.userAnswers[currentQ.id];
      if (savedAnswer != null) {
        _selectedOption = savedAnswer;
        _hasSubmitted = true;
      } else {
        _selectedOption = null;
        _hasSubmitted = false;
      }
    }
  }

  void _handleSelectOption(int index) {
    if (_hasSubmitted) return; // Prevent changing after submission

    setState(() {
      _selectedOption = index;
      _hasSubmitted = true;
    });

    final currentQ = _questions[_currentIndex];
    widget.progressService.recordAnswer(currentQ.id, index);
  }

  void _goToNext() {
    _ttsService.stop();
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _loadExistingAnswer();
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _goToPrev() {
    _ttsService.stop();
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _loadExistingAnswer();
      });
    }
  }

  void _speakQuestion(Question q) {
    _ttsService.speak(
      text: '${widget.category.title}. Pertanyaan: ${q.question}',
      speechId: 'quiz_${q.id}',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.category.title)),
        body: const Center(
          child: Text('Belum ada pertanyaan di kategori ini.'),
        ),
      );
    }

    final q = _questions[_currentIndex];
    final isCorrect = _selectedOption == q.correctOptionIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        actions: [
          ListenableBuilder(
            listenable: _ttsService,
            builder: (context, _) {
              final isSpeaking = _ttsService.currentSpeakingId == 'quiz_${q.id}' && _ttsService.isPlaying;
              return IconButton(
                tooltip: isSpeaking ? 'Hentikan Suara' : 'Dengarkan Pertanyaan',
                icon: Icon(
                  isSpeaking ? Icons.volume_off : Icons.volume_up,
                  color: isSpeaking ? AppTheme.accent : AppTheme.textSecondary,
                ),
                onPressed: () => _speakQuestion(q),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
            backgroundColor: AppTheme.surfaceElevated,
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accent),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Indicator Soal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pertanyaan ${_currentIndex + 1} dari ${_questions.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accent,
                    letterSpacing: 0.5,
                  ),
                ),
                if (_hasSubmitted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: isCorrect
                          ? AppTheme.success.withValues(alpha: 0.15)
                          : AppTheme.error.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isCorrect
                            ? AppTheme.success.withValues(alpha: 0.4)
                            : AppTheme.error.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      isCorrect ? 'BENAR ✓' : 'KURANG TEPAT ✗',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? AppTheme.success : AppTheme.error,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Question Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceElevated,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.help_outline,
                          size: 18,
                          color: AppTheme.accent,
                        ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.psychology,
                          size: 16,
                          color: AppTheme.info,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Alasan Ditanyakan: ${q.whyAsked}',
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

            // Section Label
            const Text(
              'Pilihan Jawaban:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.textSecondary,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 10),

            // Options List
            ...List.generate(q.options.length, (index) {
              return _buildOptionTile(
                index: index,
                text: q.options[index],
                correctIndex: q.correctOptionIndex,
              );
            }),

            const SizedBox(height: 16),

            // Instant Correction / Explanation Box
            if (_hasSubmitted) ...[
              _buildCorrectionSection(q, isCorrect),
              const SizedBox(height: 20),
            ],

            // Navigation Buttons
            Row(
              children: [
                if (_currentIndex > 0)
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textSecondary,
                        side: const BorderSide(color: AppTheme.cardBorder),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_back, size: 16),
                      label: const Text('Sebelumnya'),
                      onPressed: _goToPrev,
                    ),
                  ),
                if (_currentIndex > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(
                      _currentIndex < _questions.length - 1
                          ? Icons.arrow_forward
                          : Icons.check,
                      size: 16,
                    ),
                    label: Text(
                      _currentIndex < _questions.length - 1
                          ? 'Selanjutnya'
                          : 'Selesai Kategori',
                    ),
                    onPressed: _hasSubmitted ? _goToNext : null,
                  ),
                ),
              ],
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
    Widget? indicator;

    if (_hasSubmitted) {
      if (isCorrectOption) {
        borderColor = AppTheme.success;
        bgColor = AppTheme.success.withValues(alpha: 0.1);
        indicator = const Icon(Icons.check_circle, color: AppTheme.success, size: 20);
      } else if (isSelected) {
        borderColor = AppTheme.error;
        bgColor = AppTheme.error.withValues(alpha: 0.1);
        indicator = const Icon(Icons.cancel, color: AppTheme.error, size: 20);
      }
    } else if (isSelected) {
      borderColor = AppTheme.accent;
      bgColor = AppTheme.accent.withValues(alpha: 0.1);
    }

    final optionLetters = ['A', 'B', 'C', 'D'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _hasSubmitted ? null : () => _handleSelectOption(index),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.accent : AppTheme.surfaceElevated,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  optionLetters[index],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
              if (indicator != null) ...[
                const SizedBox(width: 8),
                indicator,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCorrectionSection(Question q, bool isCorrect) {
    final selectedExp = _selectedOption != null
        ? q.optionExplanations[_selectedOption]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Penjelasan Opsi yang Dipilih
        if (selectedExp != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isCorrect
                  ? AppTheme.success.withValues(alpha: 0.1)
                  : AppTheme.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCorrect
                    ? AppTheme.success.withValues(alpha: 0.4)
                    : AppTheme.error.withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCorrect ? Icons.check_circle_outline : Icons.highlight_off,
                      color: isCorrect ? AppTheme.success : AppTheme.error,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCorrect ? 'Jawaban Benar!' : 'Kenapa Pilihan Ini Keliru?',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? AppTheme.success : AppTheme.error,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  selectedExp,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),

        const SizedBox(height: 12),

        // Naskah Jawaban Ideal yang Disukai Interviewer
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.accent.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.mic, color: AppTheme.accent, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Naskah Jawaban Ideal Interviewer',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.accent,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up, size: 18, color: AppTheme.accent),
                    tooltip: 'Dengarkan Naskah Jawaban',
                    onPressed: () {
                      _ttsService.speak(
                        text: 'Naskah jawaban ideal: ${q.idealAnswer}',
                        speechId: 'ideal_${q.id}',
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                q.idealAnswer,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // Senior Tip
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceElevated,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.cardBorder),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.tips_and_updates,
                      size: 16,
                      color: AppTheme.warning,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary, height: 1.3),
                          children: [
                            const TextSpan(
                              text: 'Tips Senior Dev: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.warning,
                              ),
                            ),
                            TextSpan(text: q.seniorTip),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Keywords Chips
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: q.keyKeywords.map((kw) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppTheme.cardBorder),
                    ),
                    child: Text(
                      '#$kw',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.accent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
