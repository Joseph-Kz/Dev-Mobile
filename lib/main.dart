import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'models/music.dart';
import 'models/page_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Music Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<Music> myMusicList = [
  Music('This is JOE', 'Joe', 'assets/Joe.jpg', 'assets/SadSong.mp3'),
  Music('This is Clement', 'Clement', 'assets/Clement.jpg',
      'assets/Rick Astley  Never Gonna Give You Up Video.mp3'),
  Music('Heat Waves', 'GlassAnimals', 'assets/HeatWaves.jpeg',
      'assets/Glass Animals  Heat Waves.mp3')
];

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var i = 0;
  late AnimationController _animationController;
  bool isPlaying = false;
  final _player = AudioPlayer();
  // late final PageManager _pageManager;

  Future<void> initSong(String urlSong) async {
    await _player.setAudioSource(AudioSource.uri(Uri.parse(urlSong)));
  }

  @override
  void initState() {
    super.initState();
    initSong(myMusicList[i].urlSong);
    _pageManager = PageManager();
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Music'),
          centerTitle: true,
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        body: Center(
            //content body on scaffold
            child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset(
              myMusicList[i].imagePath, // image path
              height: 250,
            ),
            SizedBox(height: 30),
            Text(
              myMusicList[i].title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'cursive'),
            ),
            SizedBox(height: 20),
            Text(
              myMusicList[i].singer,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  fontFamily: 'Ariel'),
            ),
            SizedBox(height: 20),
            Container(
                width: 300,
                child: ProgressBar(
                  progress: Duration(seconds: 0),
                  total: Duration(seconds: 180),
                  progressBarColor: Colors.indigo,
                  thumbColor: Color.fromARGB(0, 0, 0, 0),
                  barHeight: 3.0,
                  thumbRadius: 8.0,
                  onSeek: (duration) {
                    _player.seek(duration);
                  },
                )),
            // ValueListenableBuilder<ProgressBarState>(
            //   valueListenable: _pageManager.progressNotifier,
            //   builder: (_, value, __) {
            //     return ProgressBar(
            //       progress: value.current,
            //       buffered: value.buffered,
            //       total: value.total,
            //       onSeek: _pageManager.seek,
            //     );
            //   },
            // ),
            SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.fast_rewind),
                      onPressed: () {
                        setState(
                          () {
                            if (i == 0) {
                              i = 2;
                            } else {
                              i -= 1;
                            }
                            initSong(myMusicList[i].urlSong);
                          },
                        );
                      }),
                  IconButton(
                      iconSize: 70,
                      splashColor: Color.fromARGB(255, 0, 5, 3),
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _animationController,
                      ),
                      onPressed: () => {
                            setState(() {
                              if (isPlaying) {
                                _animationController.reverse();
                                _player.pause();
                                isPlaying = false;
                              } else {
                                _animationController.forward();
                                _player.play();
                                isPlaying = true;
                              }
                            }),
                          }),
                  IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.fast_forward),
                      onPressed: () {
                        setState(() {
                          if (i == 2) {
                            i = 0;
                          } else {
                            i++;
                          }
                          initSong(myMusicList[i].urlSong);
                        });
                      }),
                ]),
          ],
        )));
  }
}
