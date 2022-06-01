import 'package:flutter/material.dart';

import 'models/music.dart';

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
      'assets/Glass Animals  Heat Waves')
];
late AnimationController _animationController;
bool isPlaying = false;

// @override
// void initState() {
//   super initState();
//   _animationController = AnimationController(
//     vsync: this, // the SingleTickerProviderStateMixin
//     duration: Duration(milliseconds: 450),
//   );
// }
// @override
// void dispose() {
//   _animationController.dispose();
//   super.dispose();
// }

class _MyHomePageState extends State<MyHomePage> {
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
              myMusicList[0].imagePath, // image path
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
            Row(children: [
              Icon(
                Icons.fast_rewind,
              ),
              IconButton(
                  iconSize: 150,
                  splashColor: Color.fromARGB(255, 0, 5, 3),
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _animationController,
                  ),
                  onPressed: () => {
                        setState(() {
                          isPlaying = !isPlaying;
                          // isPlaying
                          // ? _animationController.forward()
                          // : _animationController.reverse();
                        })
                      }),
              Icon(
                Icons.fast_forward,
              ),
            ])
          ],
        )));
  }
}
