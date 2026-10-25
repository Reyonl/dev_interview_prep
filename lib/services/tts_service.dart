import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService extends ChangeNotifier {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal() {
    _initTts();
  }

  FlutterTts? _flutterTts;
  bool _isPlaying = false;
  String? _currentSpeakingId;

  bool get isPlaying => _isPlaying;
  String? get currentSpeakingId => _currentSpeakingId;

  Future<void> _initTts() async {
    try {
      _flutterTts = FlutterTts();

      _flutterTts?.setStartHandler(() {
        _isPlaying = true;
        notifyListeners();
      });

      _flutterTts?.setCompletionHandler(() {
        _isPlaying = false;
        _currentSpeakingId = null;
        notifyListeners();
      });

      _flutterTts?.setCancelHandler(() {
        _isPlaying = false;
        _currentSpeakingId = null;
        notifyListeners();
      });

      _flutterTts?.setErrorHandler((dynamic msg) {
        debugPrint('TTS Error: $msg');
        _isPlaying = false;
        _currentSpeakingId = null;
        notifyListeners();
      });

      await _flutterTts?.setSpeechRate(0.5);
      await _flutterTts?.setPitch(1.0);
      await _flutterTts?.setLanguage('id-ID');
    } catch (e) {
      debugPrint('TTS initialization fallback: $e');
    }
  }

  Future<void> speak({required String text, String? speechId}) async {
    if (_flutterTts == null) return;

    try {
      if (_isPlaying) {
        await stop();
        if (_currentSpeakingId == speechId && speechId != null) {
          // Klik tombol yang sama saat berbicara akan mematikan suara (toggle pause)
          return;
        }
      }

      _currentSpeakingId = speechId;
      _isPlaying = true;
      notifyListeners();

      // Bersihkan karakter simbol markdown/code agar pengucapan audio lebih natural
      final cleanText = text
          .replaceAll(RegExp(r'[`*#_]'), '')
          .replaceAll(r'$', 'dollar ')
          .replaceAll('===', 'identik sama persis tiga sama dengan')
          .replaceAll('==', 'sama dengan')
          .replaceAll('->', 'panah ');

      await _flutterTts?.speak(cleanText);
    } catch (e) {
      debugPrint('TTS speak error: $e');
      _isPlaying = false;
      _currentSpeakingId = null;
      notifyListeners();
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts?.stop();
    } catch (e) {
      debugPrint('TTS stop error: $e');
    } finally {
      _isPlaying = false;
      _currentSpeakingId = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
