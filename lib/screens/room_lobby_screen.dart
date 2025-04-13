// room_lobby_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whos_the_imposter/room_controller.dart';
import 'package:whos_the_imposter/models.dart';
import 'secret_word_screen.dart';

// class RoomLobbyScreen extends StatelessWidget {
//   final bool isHost;
//   final String currentPlayerId;
//   const RoomLobbyScreen({Key? key, required this.isHost, required this.currentPlayerId}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final roomController = Provider.of<RoomController>(context);
//     return Scaffold(
//       appBar: AppBar(title: Text("Room Lobby - Room: ${roomController.room.id}")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text("Invite your friends using this link:", style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             SelectableText("mygame://join?room=${roomController.room.id}",
//                 style: TextStyle(fontSize: 18, color: Colors.blue)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text("Send Invite"),
//               onPressed: () {
//                 // In a real app, integrate a sharing plugin.
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Invite link copied to clipboard.")));
//               },
//             ),
//             SizedBox(height: 20),
//             Text("Players:", style: TextStyle(fontSize: 20)),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: roomController.room.players.length,
//                 itemBuilder: (context, index) {
//                   final player = roomController.room.players[index];
//                   return ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text(player.name),
//                     subtitle: Text(player.id == currentPlayerId ? "You" : ""),
//                   );
//                 },
//               ),
//             ),
//             if (isHost)
//               ElevatedButton(
//                 child: Text("Start Game"),
//                 onPressed: () {
//                   roomController.startGame();
//                   Navigator.pushReplacementNamed(context, '/secret');
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class RoomLobbyScreen extends StatelessWidget {
//   final bool isHost;
//   final String currentPlayerId;
//
//   const RoomLobbyScreen({Key? key, required this.isHost, required this.currentPlayerId}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<RoomController>(
//       builder: (context, roomController, child) {
//         // Display a loading indicator until the room is initialized.
//         if (roomController.room == null) {
//           return Scaffold(
//             appBar: AppBar(title: const Text("Loading...")),
//             body: const Center(child: CircularProgressIndicator()),
//           );
//         }
//
//         return Scaffold(
//           appBar: AppBar(title: const Text("Lobby")),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Room ID: ${roomController.room!.id}", style: const TextStyle(fontSize: 24)),
//                 const SizedBox(height: 20),
//                 Text("Current Player ID: ${roomController.currentPlayerId}", style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 40),
//                 // If the user is the host, show the "Start Game" button.
//                 if (isHost)
//                   ElevatedButton(
//                     onPressed: () {
//                       // Start the game by assigning roles and words.
//                       roomController.startGame();
//                       // Navigate to the SecretWordScreen.
//                       Navigator.pushReplacementNamed(context, '/secret');
//                     },
//                     child: const Text("Start Game"),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class RoomLobbyScreen extends StatelessWidget {
//   final bool isHost;
//   final String currentPlayerId;
//
//   const RoomLobbyScreen({Key? key, required this.isHost, required this.currentPlayerId})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<RoomController>(
//       builder: (context, roomController, child) {
//         // Display a loading indicator until the room is initialized.
//         if (roomController.room == null) {
//           return Scaffold(
//             appBar: AppBar(title: const Text("Loading...")),
//             body: const Center(child: CircularProgressIndicator()),
//           );
//         }
//
//         // Uncomment the below block only if you want to auto-trigger startGame() for testing:
//         // if (isHost && roomController.room!.players.isNotEmpty && roomController.room!.status != 'started') {
//         //   Future.microtask(() {
//         //     print("Automatically starting game for testing...");
//         //     roomController.startGame();
//         //     Navigator.pushReplacementNamed(context, '/secret');
//         //   });
//         // }
//
//
//         return Scaffold(
//           appBar: AppBar(title: const Text("Lobby")),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Text(
//                   "Room ID: ${roomController.room!.id}",
//                   style: const TextStyle(fontSize: 24),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "Your ID: ${roomController.currentPlayerId}",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   isHost ? "Role: Host" : "Role: Player",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   "Players in Room:",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 // List all players currently in the room.
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: roomController.room!.players.length,
//                     itemBuilder: (context, index) {
//                       final player = roomController.room!.players[index];
//                       return ListTile(
//                         title: Text(player.name),
//                         subtitle: Text("ID: ${player.id}"),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Only the host sees the Start Game button.
//                 if (isHost)
//                   ElevatedButton(
//                     onPressed: () {
//                       // Start the game by assigning roles and words.
//                       roomController.startGame();
//                       // Delay the navigation for a short period (e.g. 200ms) to allow state update.
//                       Future.delayed(const Duration(milliseconds: 200), () {
//                         //Navigate to the secret word screen.
//                         Navigator.pushReplacementNamed(context, '/secret');
//                       });
//                     },
//                     child: const Text("Start Game"),
//                   )
//                 else
//                   const Text(
//                     "Waiting for host to start the game...",
//                     style: TextStyle(fontSize: 16),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


class RoomLobbyScreen extends StatelessWidget {
  final bool isHost;
  final String currentPlayerId;

  const RoomLobbyScreen({Key? key, required this.isHost, required this.currentPlayerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomController>(
      builder: (context, roomController, child) {
        // Display a loading indicator until the room is initialized.
        if (roomController.room == null) {
          return Scaffold(
            appBar: AppBar(title: const Text("Loading...")),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text("Lobby")),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Centers the column vertically within the parent.
                crossAxisAlignment: CrossAxisAlignment.center, // Centers the children horizontally.
                children: [
                  Text(
                    "Room ID: ${roomController.room!.id}",
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Current Player ID: ${roomController.currentPlayerId}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  // If the user is the host, show the "Start Game" button.
                  if (isHost)
                    ElevatedButton(
                      onPressed: () {
                        roomController.startGame();
                        // Navigate to the SecretWordScreen using MaterialPageRoute with the current provider.
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: roomController,
                              child: const SecretWordScreen(),
                            ),
                          ),
                        );
                      },
                      child: const Text("Start Game"),
                    )
                  else
                    const Text(
                      "Waiting for host to start the game...",
                      style: TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


