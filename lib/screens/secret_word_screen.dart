// // secret_word_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:whos_the_imposter/room_controller.dart';
// import 'package:whos_the_imposter/models.dart';
// import 'description_round_screen.dart';
//
// class SecretWordScreen extends StatelessWidget {
//   const SecretWordScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final roomController = Provider.of<RoomController>(context, listen: false);
//     // Identify the current player by matching id.
//     final currentPlayer = roomController.room.players.firstWhere(
//           (p) => p.id == roomController.currentPlayerId,
//       orElse: () => roomController.room.players.first,
//     );
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Your Secret Word")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Your secret word is:", style: TextStyle(fontSize: 20)),
//             SizedBox(height: 10),
//             Text(
//               currentPlayer.word,
//               style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacementNamed(context, '/description');
//               },
//               child: Text("Got it!"),
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
import 'package:whos_the_imposter/models.dart';

class SecretWordScreen extends StatelessWidget {
  const SecretWordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomController>(
      builder: (context, roomController, child) {
        // Wait until the room is fully initialized.
        if (roomController.room == null) {
          return Scaffold(
            appBar: AppBar(title: const Text("Loading...")),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        // Find the current player using the provided id.
        final currentPlayer = roomController.room!.players.firstWhere(
              (p) => p.id == roomController.currentPlayerId,
          orElse: () => roomController.room!.players.first,
        );

        // If the word hasn't been assigned yet, show a waiting message.
        if (currentPlayer.word.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text("Waiting for Secret Word")),
            body: const Center(
              child: Text(
                "The secret word is being assigned. Please wait...",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text("Your Secret Word")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your secret word is:",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  // The secret word is assigned based on the player's role using WordPair logic,
                  // but here we only display the word without revealing whether it's for the imposter or the civilian.
                  currentPlayer.word,
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/description');
                  },
                  child: const Text("Got it!"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


