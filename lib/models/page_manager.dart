import 'package:dev_mobile/main.dart';
import 'package:dev_mobile/models/music.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

List<Music> myMusicList = [
  Music('This is JOE', 'Joe', 'assets/Joe.jpg', 'assets/SadSong.mp3'),
  Music('This is Clement', 'Clement', 'assets/Clement.jpg',
      'assets/Rick Astley  Never Gonna Give You Up Video.mp3'),
  Music('Heat Waves', 'GlassAnimals', 'assets/HeatWaves.jpeg',
      'assets/Glass Animals  Heat Waves.mp3')
];

class PageManager {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

  late AudioPlayer _player;
  void seek(Duration position) {
    _player.seek(position);
  }

  void _init() async {
    _player = AudioPlayer();
    var i = 0;
    await _player.setUrl(myMusicList[i].urlSong);

    _player.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
    _player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
    });
    _player.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}
