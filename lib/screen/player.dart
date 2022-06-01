import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/music.dart';

class Player extends StatefulWidget {
  Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _MYplayer();
}

List<Music> myMusicList = [
  Music('This is JOE', 'Joe', 'assets/Joe.jpg', 'assets/SadSong.mp3'),
  Music('This is Clement', 'Clement', 'assets/Clement.jpg',
      'assets/Rick Astley  Never Gonna Give You Up Video.mp3'),
  Music('Heat Waves', 'GlassAnimals', 'assets/HeatWaves.jpeg',
      'assets/Glass Animals  Heat Waves')
];

class _MYplayer extends State<Player> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 450),
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
              myMusicList[1].imagePath, // image path
              height: 250,
            ),
            SizedBox(height: 40),
            Text(
              myMusicList[0].title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'cursive'),
            ),
            SizedBox(height: 40),
            Text(
              myMusicList[0].singer,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  fontFamily: 'Ariel'),
            ),
            SizedBox(height: 40),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    size: 40,
                    Icons.fast_rewind,
                  ),
                  IconButton(
                      iconSize: 70,
                      splashColor: Color.fromARGB(255, 0, 5, 3),
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _animationController,
                      ),
                      onPressed: () => {
                            setState(() {
                              isPlaying = !isPlaying;
                              isPlaying
                                  ? _animationController.forward()
                                  : _animationController.reverse();
                            })
                          }),
                  Icon(
                    size: 40,
                    Icons.fast_forward,
                  ),
                ])
          ],
        )));
  }
}
