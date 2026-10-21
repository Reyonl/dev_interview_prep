class CodingTask {
  final String id;
  final String title;
  final String difficulty; // Mudah, Menengah, Tantangan
  final String scenario; // Soal yang dibacakan oleh interviewer
  final List<String> expectedPseudocode; // Tahapan logika ideal
  final String boilerplateCode; // Kode awal di editor
  final String solutionCode; // Solusi bersih senior developer
  final String interviewerSpeechScript; // Naskah yang harus diucapkan ke interviewer
  final List<String> defensiveEdgeCases; // Hal ekstra yang membuat interviewer kagum
  final List<String> requiredSyntaxPatterns; // Regex atau keyword yang dicek
  final String explanation; // Penjelasan teknis solusi

  const CodingTask({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.scenario,
    required this.expectedPseudocode,
    required this.boilerplateCode,
    required this.solutionCode,
    required this.interviewerSpeechScript,
    required this.defensiveEdgeCases,
    required this.requiredSyntaxPatterns,
    required this.explanation,
  });

  /// Evaluasi rule-based sederhana terhadap kode input pengguna
  TaskEvaluationResult evaluate(String userCode) {
    if (userCode.trim().isEmpty) {
      return TaskEvaluationResult(
        isPassed: false,
        scorePercentage: 0,
        feedback: 'Editor masih kosong. Tuliskan kode atau pseudocodemu terlebih dahulu!',
        matchedKeywords: [],
        missingKeywords: requiredSyntaxPatterns,
      );
    }

    final lower = userCode.toLowerCase();
    final matched = <String>[];
    final missing = <String>[];

    for (final pattern in requiredSyntaxPatterns) {
      if (lower.contains(pattern.toLowerCase())) {
        matched.add(pattern);
      } else {
        missing.add(pattern);
      }
    }

    final score = (matched.length / requiredSyntaxPatterns.length) * 100;
    final isPassed = score >= 70;

    String feedback;
    if (isPassed) {
      feedback = 'Luar biasa! Pola logika dan struktur kuncimu sudah lengkap sesuai standar!';
    } else {
      feedback = 'Masih ada bagian logika atau syntax penting yang belum terisi. Periksa kata kunci yang hilang di bawah!';
    }

    return TaskEvaluationResult(
      isPassed: isPassed,
      scorePercentage: score.round(),
      feedback: feedback,
      matchedKeywords: matched,
      missingKeywords: missing,
    );
  }
}

class TaskEvaluationResult {
  final bool isPassed;
  final int scorePercentage;
  final String feedback;
  final List<String> matchedKeywords;
  final List<String> missingKeywords;

  const TaskEvaluationResult({
    required this.isPassed,
    required this.scorePercentage,
    required this.feedback,
    required this.matchedKeywords,
    required this.missingKeywords,
  });
}
