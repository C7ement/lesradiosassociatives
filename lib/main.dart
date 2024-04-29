import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:radios/pages/radio_list/radio_list_page.dart';

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radios Associatives',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4DA7DD)),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/images/logo_application.png',
                  fit: BoxFit.fitWidth, // Adjust as necessary
                ),
              ),
              Flexible(
                  child: const MyHomePage(title: 'Flutter Demo Home Page')),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Provider<AudioPlayer>(
      create: (_) => AudioPlayer(),
      dispose: (_, AudioPlayer player) => player.dispose(),
      child: MaterialApp(
        theme: Theme.of(context),
        home: RadioListPage(),
      ),
    );
  }
}
