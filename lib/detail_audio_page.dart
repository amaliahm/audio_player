import 'package:audio_player/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/decoration/app_color.dart' as AppColors;

class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const DetailAudioPage(
      {Key? key, required this.booksData, required this.index})
      : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  AudioPlayer? advancedPlayer;
  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container(
                decoration: BoxDecoration(color: AppColors.audioBlueBackground),
              )),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    advancedPlayer!.stop();
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ))
                ],
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              )),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.2,
            height: screenHeight * 0.36,
            child: Container(
              height: screenHeight / 2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    widget.booksData[widget.index]["title"],
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir"),
                  ),
                  Text(
                    widget.booksData[widget.index]["text"],
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  AudioFile(
                      advancedPlayer: advancedPlayer!,
                      path: widget.booksData[widget.index]["aydio"]),
                ],
              ),
            ),
          ),
          Positioned(
              height: screenHeight * 0.16,
              top: screenHeight * 0.12,
              left: (screenWidth - 150) / 2,
              right: (screenWidth - 150) / 2,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.audioGreyBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                        image: DecorationImage(
                          image:
                              AssetImage(widget.booksData[widget.index]["img"]),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
