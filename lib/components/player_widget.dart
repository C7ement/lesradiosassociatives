import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class PlayerWidget extends StatefulWidget {
  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    final player = Provider.of<AudioPlayer>(context);

    return StreamBuilder<PlayerState>(
        stream: player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          if (!snapshot.hasData || playerState == null) return Container();
          return Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (playerState.playing)
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      player.pause();
                    },
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      player.play();
                    },
                  ),
              ],
            ),
          );
        });
  }
}
