import 'package:flutter_test/flutter_test.dart';
import 'package:dev_interview_prep/models/question.dart';
import 'package:dev_interview_prep/data/question_bank.dart';
import 'package:dev_interview_prep/data/task_bank.dart';
import 'package:dev_interview_prep/services/progress_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('Bank Soal & Kategori Integrity Tests', () {
    test('Semua pertanyaan memiliki opsi valid dan indeks jawaban benar', () {
      expect(questionBank.isNotEmpty, true);

      for (final q in questionBank) {
        expect(q.id.isNotEmpty, true);
        expect(q.options.length, greaterThanOrEqualTo(2));
        expect(q.correctOptionIndex, inInclusiveRange(0, q.options.length - 1));
        expect(q.idealAnswer.isNotEmpty, true);
        expect(q.whyAsked.isNotEmpty, true);
        expect(q.seniorTip.isNotEmpty, true);
        expect(q.keyKeywords.isNotEmpty, true);
      }
    });

    test('Semua 7 kategori QuestionCategory memiliki minimal 1 pertanyaan berbobot', () {
      expect(QuestionCategory.values.length, 7);

      for (final cat in QuestionCategory.values) {
        final matches = questionBank.where((q) => q.category == cat).toList();
        expect(matches.isNotEmpty, true, reason: 'Kategori ${cat.title} tidak boleh kosong');
      }

      // Verifikasi kategori baru: System Design & Web Security
      final systemDesignQuestions = questionBank.where((q) => q.category == QuestionCategory.systemDesign).toList();
      expect(systemDesignQuestions.length, greaterThanOrEqualTo(2));

      final securityQuestions = questionBank.where((q) => q.category == QuestionCategory.securityOwasp).toList();
      expect(securityQuestions.length, greaterThanOrEqualTo(2));
    });
  });

  group('Coding Task & Rule-Based Evaluator Tests', () {
    test('Task evaluation mendeteksi kecocokan keyword lengkap (Task 1)', () {
      final task = taskBank.first; // Kalkulator kasir
      const validCode = '''
        function hitungTotalKasir(\$items) {
          \$total = 0;
          foreach (\$items as \$item) {
             \$total += \$item['harga'] * \$item['jumlah'];
          }
          if (\$total > 100000) {
             \$total -= \$total * 0.1;
          }
          return \$total;
        }
      ''';

      final result = task.evaluate(validCode);
      expect(result.isPassed, true);
      expect(result.scorePercentage, greaterThanOrEqualTo(70));
      expect(result.missingKeywords.isEmpty, true);
    });

    test('Task 5 (Sanitasi WA) lulus evaluasi dengan keyword regex & substr', () {
      final task5 = taskBank.firstWhere((t) => t.id == 'task_5');
      const waCode = '''
        function formatNomorWA(string \$nomor): string {
          \$clean = preg_replace('/\\D/', '', \$nomor);
          if (str_starts_with(\$clean, '0')) {
            \$clean = '62' . substr(\$clean, 1);
          }
          return \$clean;
        }
      ''';
      final result = task5.evaluate(waCode);
      expect(result.isPassed, true);
      expect(result.scorePercentage, 100);
      expect(result.matchedKeywords.contains('preg_replace'), true);
      expect(result.matchedKeywords.contains('substr'), true);
    });

    test('Task 6 (Two Sum) lulus evaluasi dengan keyword hash map O(N)', () {
      final task6 = taskBank.firstWhere((t) => t.id == 'task_6');
      const twoSumCode = '''
        function cariPasangan(array \$transaksi, int \$target): array {
          \$seen = [];
          foreach (\$transaksi as \$angka) {
            \$sisa = \$target - \$angka;
            if (isset(\$seen[\$sisa])) {
              return [\$sisa, \$angka];
            }
            \$seen[\$angka] = true;
          }
          return [];
        }
      ''';
      final result = task6.evaluate(twoSumCode);
      expect(result.isPassed, true);
      expect(result.scorePercentage, 100);
      expect(result.matchedKeywords.contains('isset'), true);
    });

    test('Task evaluation mendeteksi kegagalan jika kode kosong atau kurang keyword', () {
      final task = taskBank.first;
      final emptyResult = task.evaluate('');
      expect(emptyResult.isPassed, false);
      expect(emptyResult.scorePercentage, 0);

      final incompleteResult = task.evaluate('function hitung() { return 0; }');
      expect(incompleteResult.isPassed, false);
      expect(incompleteResult.missingKeywords.contains('foreach'), true);
    });
  });

  group('Progress Service Scoring Tests', () {
    test('Perhitungan kesiapan awal adalah 0% jika belum ada jawaban', () {
      final service = ProgressService();
      expect(service.calculateOverallReadiness(), 0);
    });

    test('Perekaman jawaban benar meningkatkan skor kategori dan overall', () async {
      final service = ProgressService();
      final q1 = questionBank.first;

      await service.recordAnswer(q1.id, q1.correctOptionIndex);

      expect(service.userAnswers[q1.id], q1.correctOptionIndex);
      expect(service.calculateCategoryScore(q1.category), greaterThan(0));
      expect(service.calculateOverallReadiness(), greaterThan(0));
    });
  });
}
