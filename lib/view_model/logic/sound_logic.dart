import 'package:just_audio/just_audio.dart';

class SoundLogic {
  final AudioPlayer _player = AudioPlayer();
  Future<void> audioPlay(file) async {
    await _player.setAsset(file);
    print('abc');
    await _player.play();

  }
  Future<void> audioStop() async {
    await _player.stop();

  }
  Future<void> audioResume() async {
    await _player.play();

  }



}
