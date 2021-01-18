
import 'package:aunty_rafiki/models/audio.dart';

import 'package:flutter/material.dart';

class AudioCard extends StatefulWidget {
  final Audio audio;

  AudioCard({Key key, @required this.audio}) : super(key: key);

  @override
  _AudioCardState createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {

  bool _isPlaying = false;
  Duration duration;
  @override
  void initState() {
    // audioPlayer.onDurationChanged.listen((Duration d) =>{
    //   print('Max duration: $d')
    //  // setState(() => duration = d);
    // });

  //    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s)  {
  //   print('Current player state: $s');
  //   setState(() => playerState = s);
  // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListTile(
        leading: IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () async {
              print(duration);
              if (!_isPlaying) {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
               // await audioPlayer.play(widget.audio.url);
              } else {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
             //   audioPlayer.stop();
              }
            }),
        trailing: Text(widget.audio.duration),
      ),
    );
  }
}
