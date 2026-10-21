enum QuestionCategory {
  hr,
  corePhp,
  laravel,
  database,
  gitWorkflow,
}

extension QuestionCategoryExtension on QuestionCategory {
  String get title {
    switch (this) {
      case QuestionCategory.hr:
        return 'HR & Behavioral';
      case QuestionCategory.corePhp:
        return 'Core PHP & OOP';
      case QuestionCategory.laravel:
        return 'Laravel Framework';
      case QuestionCategory.database:
        return 'Database & SQL';
      case QuestionCategory.gitWorkflow:
        return 'Git & Team Workflow';
    }
  }

  String get iconName {
    switch (this) {
      case QuestionCategory.hr:
        return 'person';
      case QuestionCategory.corePhp:
        return 'code';
      case QuestionCategory.laravel:
        return 'layers';
      case QuestionCategory.database:
        return 'storage';
      case QuestionCategory.gitWorkflow:
        return 'alt_route';
    }
  }
}

class Question {
  final String id;
  final QuestionCategory category;
  final String question;
  final String whyAsked; // Alasan pewawancara menanyakan ini
  final List<String> options;
  final int correctOptionIndex;
  final String idealAnswer; // Jawaban terbaik yang disukai interviewer
  final String seniorTip; // Cara membungkus jawaban agar dinilai matang
  final Map<int, String> optionExplanations; // Mengapa opsi ini salah / benar
  final List<String> keyKeywords; // Kata kunci wajib

  const Question({
    required this.id,
    required this.category,
    required this.question,
    required this.whyAsked,
    required this.options,
    required this.correctOptionIndex,
    required this.idealAnswer,
    required this.seniorTip,
    required this.optionExplanations,
    required this.keyKeywords,
  });
}
