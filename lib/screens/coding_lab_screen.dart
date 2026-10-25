import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/coding_task.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../services/tts_service.dart';

class CodingLabScreen extends StatefulWidget {
  final CodingTask task;
  final ProgressService progressService;

  const CodingLabScreen({
    super.key,
    required this.task,
    required this.progressService,
  });

  @override
  State<CodingLabScreen> createState() => _CodingLabScreenState();
}

class _CodingLabScreenState extends State<CodingLabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _codeController;
  TaskEvaluationResult? _evalResult;
  bool _showSeniorSolution = false;
  final TtsService _ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _codeController = TextEditingController(text: widget.task.boilerplateCode);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _ttsService.stop();
    _codeController.dispose();
    super.dispose();
  }

  void _runEvaluation() {
    setState(() {
      _evalResult = widget.task.evaluate(_codeController.text);
      if (_evalResult!.isPassed) {
        widget.progressService.recordTaskCompleted(widget.task.id);
      }
    });
  }

  void _insertTemplatePseudocode() {
    final buffer = StringBuffer();
    buffer.writeln('<?php');
    buffer.writeln();
    buffer.writeln('// ── ALUR LOGIKA PSEUDOCODE: ──');
    for (final step in widget.task.expectedPseudocode) {
      buffer.writeln('// $step');
    }
    buffer.writeln();
    buffer.writeln('// ── TULIS IMPLEMENTASI KODE DI BAWAH: ──');
    buffer.writeln();

    setState(() {
      _codeController.text = buffer.toString() + widget.task.boilerplateCode;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pseudocode disisipkan ke editor sebagai komentar!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDone = widget.progressService.completedTaskIds.contains(widget.task.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
        actions: [
          if (isDone)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: AppTheme.success, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Tuntas',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.success,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accent,
          labelColor: AppTheme.accent,
          unselectedLabelColor: AppTheme.textSecondary,
          tabs: const [
            Tab(icon: Icon(Icons.record_voice_over, size: 18), text: 'Alur & Naskah'),
            Tab(icon: Icon(Icons.terminal, size: 18), text: 'Live Code Editor'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWorkflowTab(),
          _buildEditorTab(),
        ],
      ),
    );
  }

  // ─── TAB 1: ALUR PSEUDOCODE & NASKAH UCAPAN ─────────────────────────────
  Widget _buildWorkflowTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Skenario Soal
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'SOAL DARI PEWAWANCARA:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        color: AppTheme.accent,
                      ),
                    ),
                    Text(
                      widget.task.difficulty,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.info,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.task.scenario,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Tahapan Pseudocode Ideal
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.format_list_numbered, size: 18, color: AppTheme.info),
                        SizedBox(width: 8),
                        Text(
                          'Tahap Logika (Ketik Dulu di Layar):',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.copy, size: 14),
                      label: const Text('Sisipkan ke Editor', style: TextStyle(fontSize: 11)),
                      onPressed: _insertTemplatePseudocode,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...widget.task.expectedPseudocode.map((step) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          step,
                          style: const TextStyle(fontSize: 12, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Naskah Ucapan ke Interviewer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceElevated,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.accent.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.record_voice_over, size: 18, color: AppTheme.accent),
                    SizedBox(width: 8),
                    Text(
                      'Naskah yang Kamu Ucapkan ke Interviewer:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.task.interviewerSpeechScript,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    fontStyle: FontStyle.italic,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListenableBuilder(
                      listenable: _ttsService,
                      builder: (context, _) {
                        final isSpeaking = _ttsService.currentSpeakingId == 'task_speech_${widget.task.id}' && _ttsService.isPlaying;
                        return TextButton.icon(
                          icon: Icon(isSpeaking ? Icons.volume_off : Icons.volume_up, size: 14),
                          label: Text(isSpeaking ? 'Hentikan' : 'Dengarkan Naskah', style: const TextStyle(fontSize: 11)),
                          onPressed: () {
                            _ttsService.speak(
                              text: widget.task.interviewerSpeechScript,
                              speechId: 'task_speech_${widget.task.id}',
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      icon: const Icon(Icons.copy, size: 14),
                      label: const Text('Salin Naskah', style: TextStyle(fontSize: 11)),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.task.interviewerSpeechScript));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Naskah ucapan disalin ke clipboard!')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Edge Cases Defensif
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
                const Row(
                  children: [
                    Icon(Icons.shield_outlined, size: 18, color: AppTheme.success),
                    SizedBox(width: 8),
                    Text(
                      'Nilai Tambah: Kasus Batas (Edge Cases)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...widget.task.defensiveEdgeCases.map((edge) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('✓ ', style: TextStyle(color: AppTheme.success, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          edge,
                          style: const TextStyle(fontSize: 12, height: 1.35, color: AppTheme.textSecondary),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit, size: 18),
              label: const Text('Buka Code Editor untuk Praktek'),
              onPressed: () => _tabController.animateTo(1),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ─── TAB 2: CODE EDITOR & EVALUASI ──────────────────────────────────────
  Widget _buildEditorTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tuliskan Solusi / Pseudocodemu:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                icon: const Icon(Icons.restore, size: 14),
                label: const Text('Reset Template', style: TextStyle(fontSize: 11)),
                onPressed: () {
                  setState(() {
                    _codeController.text = widget.task.boilerplateCode;
                    _evalResult = null;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Code Editor Box
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF070A10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _codeController,
              maxLines: 14,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Color(0xFFE5E7EB),
                height: 1.45,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Tulis kode atau pseudocodemu di sini...',
                hintStyle: TextStyle(color: AppTheme.textMuted),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Periksa Solusi'),
                  onPressed: _runEvaluation,
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                icon: Icon(
                  _showSeniorSolution ? Icons.visibility_off : Icons.visibility,
                  size: 16,
                ),
                label: Text(_showSeniorSolution ? 'Tutup Solusi' : 'Lihat Solusi'),
                onPressed: () {
                  setState(() {
                    _showSeniorSolution = !_showSeniorSolution;
                  });
                },
              ),
            ],
          ),

          // ─── HASIL EVALUASI MANDIRI ─────────────────────────────────────
          if (_evalResult != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _evalResult!.isPassed
                    ? AppTheme.success.withValues(alpha: 0.12)
                    : AppTheme.error.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _evalResult!.isPassed
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
                        _evalResult!.isPassed
                            ? Icons.check_circle
                            : Icons.error_outline,
                        color: _evalResult!.isPassed
                            ? AppTheme.success
                            : AppTheme.error,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _evalResult!.isPassed
                            ? 'LULUS VERIFIKASI (${_evalResult!.scorePercentage}%) ✓'
                            : 'BELUM LULUS (${_evalResult!.scorePercentage}%) ✗',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _evalResult!.isPassed
                              ? AppTheme.success
                              : AppTheme.error,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _evalResult!.feedback,
                    style: const TextStyle(fontSize: 12, height: 1.35),
                  ),
                  if (_evalResult!.missingKeywords.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Elemen logika/syntax yang belum terdeteksi: ${_evalResult!.missingKeywords.join(', ')}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.warning,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],

          // ─── SOLUSI BERSIH SENIOR DEVELOPER ─────────────────────────────
          if (_showSeniorSolution) ...[
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceElevated,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SOLUSI BERSIH SENIOR DEVELOPER:',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                          color: AppTheme.success,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 16),
                        tooltip: 'Salin Solusi',
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: widget.task.solutionCode));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Solusi disalin ke clipboard!')),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF070A10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.task.solutionCode,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Color(0xFF34D399),
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.task.explanation,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
