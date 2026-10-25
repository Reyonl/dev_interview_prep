import 'package:flutter/material.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../models/question.dart';
import '../data/question_bank.dart';
import '../data/task_bank.dart';
import 'quiz_screen.dart';
import 'coding_lab_screen.dart';
import 'mock_interview_screen.dart';

class HomeScreen extends StatelessWidget {
  final ProgressService progressService;

  const HomeScreen({super.key, required this.progressService});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: progressService,
      builder: (context, _) {
        final readiness = progressService.calculateOverallReadiness();

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.accent.withValues(alpha: 0.4)),
                  ),
                  child: const Icon(Icons.terminal, color: AppTheme.accent, size: 20),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DevInterview Prep',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Simulasi Wawancara & Live Coding',
                      style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: 'Reset Latihan',
                icon: const Icon(Icons.refresh, size: 20, color: AppTheme.textSecondary),
                onPressed: () => _confirmReset(context),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── READINESS INDEX CARD ────────────────────────────────
                _buildReadinessCard(context, readiness),

                const SizedBox(height: 16),

                // ─── MOCK INTERVIEW MODE BANNER ──────────────────────────
                _buildMockInterviewCard(context),

                const SizedBox(height: 24),

                // ─── KATEGORI PERTANYAAN WAWANCARA ───────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Simulasi Tanya Jawab',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${questionBank.length} Soal (${QuestionCategory.values.length} Kategori)',
                      style: const TextStyle(fontSize: 12, color: AppTheme.accent),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildCategoryGrid(context),

                const SizedBox(height: 28),

                // ─── LIVE CODING & LOGIC LAB ─────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Live Coding & Pseudocode Lab',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${taskBank.length} Tugas',
                      style: const TextStyle(fontSize: 12, color: AppTheme.info),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Latihan membuat alur logika di layar dan naskah ucapan ke pewawancara.',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 12),
                _buildTaskList(context),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReadinessCard(BuildContext context, int readiness) {
    String statusTitle;
    String statusSub;
    Color statusColor;

    if (readiness >= 80) {
      statusTitle = 'Siap Tempur Interview! 🔥';
      statusSub = 'Pondasi logika dan jawaban strategismu sudah sangat solid.';
      statusColor = AppTheme.success;
    } else if (readiness >= 40) {
      statusTitle = 'Performa Menanjak 👍';
      statusSub = 'Lanjutkan latihan pada kategori yang masih sering salah.';
      statusColor = AppTheme.accent;
    } else {
      statusTitle = 'Fase Membangun Fondasi 🚀';
      statusSub = 'Mulai pelajari pertanyaan dan latihan tugas live coding di bawah!';
      statusColor = AppTheme.info;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.cardBorder),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.surface,
            AppTheme.surfaceElevated.withValues(alpha: 0.6),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SKOR KESIAPAN WAWANCARA',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: AppTheme.accent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    statusTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '$readiness%',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            statusSub,
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: readiness / 100,
              minHeight: 8,
              backgroundColor: Colors.black26,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockInterviewCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.accent.withValues(alpha: 0.18),
            AppTheme.surfaceElevated,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.accent.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'FITUR BARU',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.success.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppTheme.success.withValues(alpha: 0.4)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.volume_up, size: 12, color: AppTheme.success),
                    SizedBox(width: 4),
                    Text(
                      'TTS Audio Voice',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Simulasi Ujian Wawancara (Mock Exam)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Uji kesiapan mentalmu: 10 pertanyaan acak, batas waktu 60 detik per soal, audio pembacaan soal otomatis, dan evaluasi kelulusan.',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MockInterviewScreen(
                      progressService: progressService,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.timer_outlined, size: 18),
              label: const Text(
                'Mulai Simulasi Wawancara ⏱️',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    return Column(
      children: QuestionCategory.values.map((cat) {
        final score = progressService.calculateCategoryScore(cat);
        final questions = questionBank.where((q) => q.category == cat).toList();

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    category: cat,
                    progressService: progressService,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.cardBorder),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.cardBorder),
                    ),
                    child: Icon(
                      _getCategoryIcon(cat),
                      color: AppTheme.accent,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${questions.length} Pertanyaan • Akurasi: $score%',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: score >= 80
                          ? AppTheme.success.withValues(alpha: 0.15)
                          : AppTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: score >= 80
                            ? AppTheme.success.withValues(alpha: 0.4)
                            : AppTheme.cardBorder,
                      ),
                    ),
                    child: Text(
                      score >= 80 ? 'Mastered ✓' : 'Latihan →',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: score >= 80 ? AppTheme.success : AppTheme.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTaskList(BuildContext context) {
    return Column(
      children: taskBank.map((task) {
        final isDone = progressService.completedTaskIds.contains(task.id);

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CodingLabScreen(
                    task: task,
                    progressService: progressService,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDone
                      ? AppTheme.success.withValues(alpha: 0.4)
                      : AppTheme.cardBorder,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDone
                          ? AppTheme.success.withValues(alpha: 0.15)
                          : AppTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isDone ? Icons.check_circle : Icons.code,
                      color: isDone ? AppTheme.success : AppTheme.info,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(task.difficulty).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                task.difficulty,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getDifficultyColor(task.difficulty),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isDone ? 'Tuntas' : 'Belum Selesai',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDone ? AppTheme.success : AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: AppTheme.textMuted,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  IconData _getCategoryIcon(QuestionCategory cat) {
    switch (cat) {
      case QuestionCategory.hr:
        return Icons.record_voice_over;
      case QuestionCategory.corePhp:
        return Icons.code;
      case QuestionCategory.laravel:
        return Icons.layers;
      case QuestionCategory.database:
        return Icons.dns;
      case QuestionCategory.gitWorkflow:
        return Icons.fork_right;
      case QuestionCategory.systemDesign:
        return Icons.hub;
      case QuestionCategory.securityOwasp:
        return Icons.security;
    }
  }

  Color _getDifficultyColor(String diff) {
    switch (diff) {
      case 'Mudah':
        return AppTheme.success;
      case 'Menengah':
        return AppTheme.warning;
      default:
        return AppTheme.error;
    }
  }

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Reset Latihan?'),
        content: const Text(
          'Semua progres jawaban dan tugas coding yang tersimpan akan dikembalikan ke 0.',
        ),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.pop(ctx),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: const Text('Reset', style: TextStyle(color: Colors.white)),
            onPressed: () {
              progressService.resetAll();
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }
}
