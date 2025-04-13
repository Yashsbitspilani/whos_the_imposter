// // game_over_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:whos_the_imposter/room_controller.dart';
// import '../models.dart';
//
// class GameOverScreen extends StatelessWidget {
//   const GameOverScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final roomController = Provider.of<RoomController>(context);
//     return Scaffold(
//       appBar: AppBar(title: Text("Game Over")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Game Over!", style: TextStyle(fontSize: 32)),
//             Text("Remaining players:"),
//             ...roomController.room.players.map((p) => Text("${p.name} - ${p.role == Role.imposter ? 'Imposter' : 'Civilian'}")),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacementNamed(context, '/lobby');
//               },
//               child: Text("Back to Lobby"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whos_the_imposter/room_controller.dart';
import '../models.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomController>(
      builder: (context, roomController, child) {
        if (roomController.room == null) {
          return Scaffold(
            appBar: AppBar(title: const Text("Loading...")),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text("Game Over")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Game Over!", style: TextStyle(fontSize: 32)),
                const SizedBox(height: 10),
                const Text("Remaining players:"),
                ...roomController.room!.players.map((p) => Text(
                    "${p.name} - ${p.role == Role.imposter ? 'Imposter' : 'Civilian'}")),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/lobby');
                  },
                  child: const Text("Back to Lobby"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
