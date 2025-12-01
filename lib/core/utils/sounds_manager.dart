import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playSound(String soundPath) async {
    await _audioPlayer.setSource(AssetSource(soundPath));
    await _audioPlayer.seek(Duration.zero);
    await _audioPlayer.resume();
  }

  static void disposeSoundPlayer() {
    _audioPlayer.dispose();
  }
}
