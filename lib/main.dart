// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whos_the_imposter/screens/room_creation_screen.dart';
import 'package:whos_the_imposter/screens/room_lobby_screen.dart';
import 'package:whos_the_imposter/screens/secret_word_screen.dart';
import 'package:whos_the_imposter/screens/description_round_screen.dart';
import 'package:whos_the_imposter/screens/voting_screen.dart';
import 'package:whos_the_imposter/screens/game_over_screen.dart';
import 'package:whos_the_imposter/room_controller.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RoomController(currentPlayerId: 'player1', isHost: true)),
    ],
    child: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imposter Word Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/room_creation',
      routes: {
        '/room_creation': (context) => const RoomCreationScreen(fixedPlayerId: 'player1'),
        '/lobby': (context) => RoomLobbyScreen(isHost: true, currentPlayerId: 'player1'), // This will be replaced via MaterialPageRoute.
        '/secret': (context) => const SecretWordScreen(),
        '/description': (context) => const DescriptionRoundScreen(),
        '/voting': (context) => const VotingScreen(),
        '/gameover': (context) => const GameOverScreen(),
      },
    );
  }
}
