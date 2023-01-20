import 'package:just_audio/just_audio.dart';

class SoundLogic {
  final AudioPlayer _player = AudioPlayer();
  Future<void> audioPlay(file) async {
    await _player.setAsset(file);
    print('a');
    await _player.play();
  }
  Future<void> audioStop() async {
    await _player.stop();
  }


}
