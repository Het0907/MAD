import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static FlutterTts? _flutterTts;
  static AudioPlayer? _audioPlayer;

  static Future<void> initialize() async {
    _flutterTts = FlutterTts();
    _audioPlayer = AudioPlayer();
    
    await _flutterTts!.setLanguage('en-US');
    await _flutterTts!.setSpeechRate(0.5);
    await _flutterTts!.setVolume(1.0);
    await _flutterTts!.setPitch(1.2);
  }

  static Future<void> speak(String text) async {
    if (_flutterTts != null) {
      await _flutterTts!.speak(text);
    }
  }

  static Future<void> playSound(String soundPath) async {
    if (_audioPlayer != null) {
      try {
        await _audioPlayer!.play(AssetSource(soundPath));
      } catch (e) {
        print('Error playing sound: $e');
      }
    }
  }

  static Future<void> stop() async {
    await _flutterTts?.stop();
    await _audioPlayer?.stop();
  }

  static void dispose() {
    _audioPlayer?.dispose();
  }
}