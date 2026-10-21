import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/question_bank.dart';
import '../services/progress_service.dart';
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
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _loadExistingAnswer();
      });
    }
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
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? AppTheme.success : AppTheme.error,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Card Pertanyaan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    q.question,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.psychology, size: 16, color: AppTheme.info),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Tujuan Pertanyaan: ${q.whyAsked}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Pilih Pendekatan Jawabanmu:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 10),

            // Pilihan Jawaban
            ...List.generate(q.options.length, (index) {
              final optionText = q.options[index];
              final isChosen = _selectedOption == index;
              final isTargetCorrect = q.correctOptionIndex == index;

              Color borderColor = AppTheme.cardBorder;
              Color bgColor = AppTheme.surface;
              Widget icon = Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.cardBorder, width: 2),
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ),
              );

              if (_hasSubmitted) {
                if (isTargetCorrect) {
                  borderColor = AppTheme.success;
                  bgColor = AppTheme.success.withValues(alpha: 0.08);
                  icon = const Icon(Icons.check_circle, color: AppTheme.success, size: 24);
                } else if (isChosen && !isTargetCorrect) {
                  borderColor = AppTheme.error;
                  bgColor = AppTheme.error.withValues(alpha: 0.08);
                  icon = const Icon(Icons.cancel, color: AppTheme.error, size: 24);
                }
              } else if (isChosen) {
                borderColor = AppTheme.accent;
                bgColor = AppTheme.accent.withValues(alpha: 0.08);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: _hasSubmitted ? null : () => _handleSelectOption(index),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: borderColor, width: isChosen || (_hasSubmitted && isTargetCorrect) ? 1.5 : 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        icon,
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            optionText,
                            style: TextStyle(
                              fontSize: 13,
                              color: (_hasSubmitted && isChosen && !isTargetCorrect)
                                  ? AppTheme.error
                                  : AppTheme.textPrimary,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // ─── PANEL KOREKSI & PENJELASAN SAAT SUDAH DIJAWAB ────────────
            if (_hasSubmitted) ...[
              const SizedBox(height: 14),

              // Penjelasan Opsi yang dipilih jika salah
              if (!isCorrect && _selectedOption != null && q.optionExplanations.containsKey(_selectedOption)) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.error.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: AppTheme.error, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Koreksi Jawabanmu:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.error,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        q.optionExplanations[_selectedOption]!,
                        style: const TextStyle(fontSize: 12, color: AppTheme.textPrimary, height: 1.35),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],

              // Jawaban Ideal di Hadapan Pewawancara
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceElevated,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.success.withValues(alpha: 0.35)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.mic, color: AppTheme.success, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Cara Menjawab Ideal di Hadapan Interviewer:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      q.idealAnswer,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textPrimary,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: AppTheme.cardBorder),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.tips_and_updates, color: AppTheme.accent, size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Tips Senior: ${q.seniorTip}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.accent,
                              fontStyle: FontStyle.italic,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],

            // ─── NAVIGASI SOAL ────────────────────────────────────────────
            Row(
              children: [
                if (_currentIndex > 0)
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back, size: 16),
                      label: const Text('Sebelumnya'),
                      onPressed: _goToPrev,
                    ),
                  ),
                if (_currentIndex > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(
                      _currentIndex == _questions.length - 1
                          ? Icons.check
                          : Icons.arrow_forward,
                      size: 16,
                    ),
                    label: Text(
                      _currentIndex == _questions.length - 1
                          ? 'Selesai'
                          : 'Selanjutnya',
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
}
