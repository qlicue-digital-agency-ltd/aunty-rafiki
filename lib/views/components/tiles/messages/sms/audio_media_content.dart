// import 'dart:async';

//import 'package:audioplayers/audioplayers.dart';
import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum PlayerState { stopped, playing, paused }
enum PlayingRouteState { speakers, earpiece }

class PlayerWidget extends StatefulWidget {
  //final PlayerMode mode;
  final Message message;
  final double width;

  PlayerWidget(
      {Key key,
      @required this.message,
      //this.mode = PlayerMode.MEDIA_PLAYER,
      @required this.width})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  String url;
  //PlayerMode mode;

  // AudioPlayer _audioPlayer;
  // AudioPlayerState audioPlayerState;
  // Duration _duration;
  // Duration _position;

  // PlayerState _playerState = PlayerState.stopped;
  PlayingRouteState playingRouteState = PlayingRouteState.speakers;
  // StreamSubscription _durationSubscription;
  // StreamSubscription _positionSubscription;
  // StreamSubscription _playerCompleteSubscription;
  // StreamSubscription _playerErrorSubscription;
  // StreamSubscription _playerStateSubscription;
  //StreamSubscription<PlayerControlCommand> _playerControlCommandSubscription;

  // get _isPlaying => _playerState == PlayerState.playing;
  // get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  // get _positionText => _position?.toString()?.split('.')?.first ?? '';

  //_PlayerWidgetState(this.url, this.mode);

  @override
  void initState() {
    super.initState();
   // _initAudioPlayer();
  }

  @override
  void dispose() {
    // _audioPlayer.dispose();
    // _durationSubscription?.cancel();
    // _positionSubscription?.cancel();
    // _playerCompleteSubscription?.cancel();
    // _playerErrorSubscription?.cancel();
    // _playerStateSubscription?.cancel();
    // _playerControlCommandSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = new DateFormat('HH:mm');
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               
                // Row(
                //   children: [
                //     Wrap(
                //       children: [
                //         _isPlaying
                //             ? IconButton(
                //                 key: Key('pause_button'),
                //                 onPressed: _isPlaying ? () => _pause() : null,
                //                 iconSize: 30.0,
                //                 icon: Icon(Icons.pause),
                //                 color: Colors.cyan,
                //               )
                //             : IconButton(
                //                 key: Key('play_button'),
                //                 onPressed: _isPlaying ? null : () => _play(),
                //                 iconSize: 30.0,
                //                 icon: Icon(Icons.play_arrow),
                //                 color: Colors.cyan,
                //               ),
                //         SizedBox(height: 68)
                //       ],
                //     ),
                //     // Expanded(
                //     //   child: Wrap(
                //     //     children: [
                //     //       Slider(
                //     //         onChanged: (v) {
                //     //           final position = v * _duration.inMilliseconds;
                //     //           _audioPlayer.seek(
                //     //               Duration(milliseconds: position.round()));
                //     //         },
                //     //         value: (_position != null &&
                //     //                 _duration != null &&
                //     //                 _position.inMilliseconds > 0 &&
                //     //                 _position.inMilliseconds <
                //     //                     _duration.inMilliseconds)
                //     //             ? _position.inMilliseconds /
                //     //                 _duration.inMilliseconds
                //     //             : 0.0,
                //     //       ),
                //     //       Positioned(
                //     //         bottom: 0,
                //     //         right: 0,
                //     //         child: Container(
                //     //           padding:
                //     //               const EdgeInsets.only(right: 4, bottom: 2),
                //     //           child: Row(
                //     //             children: [
                //     //               SizedBox(
                //     //                 width: 20,
                //     //               ),
                //     //               Text('${_positionText ?? ''}'),
                //     //               Spacer(),
                //     //               Text('${_durationText ?? ''}'),
                //     //               SizedBox(
                //     //                 width: 20,
                //     //               ),
                //     //             ],
                //     //           ),
                //     //         ),
                //     //       ),
                //     //     ],
                //     //   ),
                //     // ),
                //   ],
                // ),
              
              
              ],
            ),
            widget.message.text.isNotEmpty
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: widget.width - 80),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        child: Text(
                          widget.message.text,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            widget.message.text.isNotEmpty
                ? SizedBox(
                    height: 5,
                  )
                : Container(),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(right: 4, bottom: 2),
            child: Text(
              '${formatter.format(widget.message.time)}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // void _initAudioPlayer() {
  //   _audioPlayer = AudioPlayer(mode: mode);

  //   _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
  //     setState(() => _duration = duration);

  //     if (Theme.of(context).platform == TargetPlatform.iOS) {
  //       // (Optional) listen for notification updates in the background
  //       _audioPlayer.startHeadlessService();

  //       // set at least title to see the notification bar on ios.
  //       _audioPlayer.setNotification(
  //         title: 'App Name',
  //         artist: 'Artist or blank',
  //         albumTitle: 'Name or blank',
  //         imageUrl: 'url or blank',
  //         // forwardSkipInterval: const Duration(seconds: 30), // default is 30s
  //         // backwardSkipInterval: const Duration(seconds: 30), // default is 30s
  //         duration: duration,
  //         elapsedTime: Duration(seconds: 0),
  //         hasNextTrack: true,
  //         hasPreviousTrack: false,
  //       );
  //     }
  //   });

  //   _positionSubscription =
  //       _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
  //             _position = p;
  //           }));

  //   _playerCompleteSubscription =
  //       _audioPlayer.onPlayerCompletion.listen((event) {
  //     _onComplete();
  //     setState(() {
  //       _position = _duration;
  //     });
  //   });

  //   _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
  //     print('audioPlayer error : $msg');
  //     setState(() {
  //       _playerState = PlayerState.stopped;
  //       _duration = Duration(seconds: 0);
  //       _position = Duration(seconds: 0);
  //     });
  //   });

  //   _playerControlCommandSubscription =
  //       _audioPlayer.onPlayerCommand.listen((command) {
  //     print('command');
  //   });

  //   _audioPlayer.onPlayerStateChanged.listen((state) {
  //     if (!mounted) return;
  //     setState(() {
  //       audioPlayerState = state;
  //     });
  //   });

  //   _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
  //     if (!mounted) return;
  //     setState(() => audioPlayerState = state);
  //   });

  //   playingRouteState = PlayingRouteState.speakers;
  // }

  // Future<int> _play() async {
  //   final playPosition = (_position != null &&
  //           _duration != null &&
  //           _position.inMilliseconds > 0 &&
  //           _position.inMilliseconds < _duration.inMilliseconds)
  //       ? _position
  //       : null;
  //   final result = await _audioPlayer.play(url, position: playPosition);
  //   if (result == 1) setState(() => _playerState = PlayerState.playing);

  //   // default playback rate is 1.0
  //   // this should be called after _audioPlayer.play() or _audioPlayer.resume()
  //   // this can also be called everytime the user wants to change playback rate in the UI
  //   _audioPlayer.setPlaybackRate(playbackRate: 1.0);

  //   return result;
  // }

  // Future<int> _pause() async {
  //   final result = await _audioPlayer.pause();
  //   if (result == 1) setState(() => _playerState = PlayerState.paused);
  //   return result;
  // }

  // void _onComplete() {
  //   setState(() => _playerState = PlayerState.stopped);
  // }



}
