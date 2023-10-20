import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer? advancedPlayer;
  final String? path;
  const AudioFile({Key? key, required this.advancedPlayer, required this.path}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _poistion = const Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  bool isRepeat = false;
  double vitesse = 1;
  List<IconData> _icons = [Icons.play_circle_fill, Icons.pause_circle_filled];

  @override
  void initState() {
    super.initState();
    widget.advancedPlayer!.onDurationChanged.listen((event) {
      setState(() {
        _duration = event;
      });
    });
    widget.advancedPlayer!.onPositionChanged.listen((event) {
      setState(() {
        _poistion = event;
      });
    });
    widget.advancedPlayer!.setSourceUrl(widget.path!);
    widget.advancedPlayer!.onPlayerComplete.listen((event) {
      setState(() {
        _poistion = const Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnStart() {
    return IconButton(
        padding: const EdgeInsets.only(bottom: 10),
        onPressed: () {
          if (isPlaying == false) {
            widget.advancedPlayer!.play(UrlSource(widget.path!));
            setState(() {
              isPlaying = true;
            });
          } else if (isPlaying == true) {
            widget.advancedPlayer!.pause();
            setState(() {
              isPlaying = false;
            });
          }
        },
        icon: isPlaying == false
            ? Icon(
                _icons[0],
                size: 50,
                color: Colors.blue,
              )
            : Icon(
                _icons[1],
                size: 50,
                color: Colors.blue,
              ));
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
      value: _poistion.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  Widget btnFast() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer!
              .setPlaybackRate(vitesse == 2 ? 2 : vitesse + 0.5);
        },
        icon: const ImageIcon(
          AssetImage("lib/decoration/img/forward.png"),
          size: 15,
          color: Colors.black,
        ));
  }

  Widget btnSlow() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer!
              .setPlaybackRate(vitesse == 2 ? 2 : vitesse - 0.5);
        },
        icon: const ImageIcon(
          AssetImage("lib/decoration/img/backword.png"),
          size: 15,
          color: Colors.black,
        ));
  }

  Widget btnLoop() {
    return IconButton(
        onPressed: () {},
        icon: const ImageIcon(
          AssetImage("lib/decoration/img/loop.png"),
          size: 15,
          color: Colors.black,
        ));
  }

  Widget btnRepeat() {
    return IconButton(
        onPressed: () {
          if (isRepeat == false) {
            widget.advancedPlayer!.setReleaseMode(ReleaseMode.loop);
            setState(() {
              isRepeat = true;
            });
          } else if (isRepeat == true) {
            widget.advancedPlayer!.setReleaseMode(ReleaseMode.release);
            setState(() {
              isRepeat = false;
            });
          }
        },
        icon: ImageIcon(
          AssetImage("lib/decoration/img/repeat.png"),
          size: 15,
          color: isRepeat ? Colors.blue : Colors.black,
        ));
  }

  void changeToSecond(int second) {
    Duration _new = Duration(seconds: second);
    widget.advancedPlayer!.seek(_new);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _poistion.toString().split(".")[0],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _duration.toString().split(".")[0],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ]),
          ),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}
