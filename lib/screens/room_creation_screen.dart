// // room_creation_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:whos_the_imposter/room_controller.dart';
// import 'package:whos_the_imposter/models.dart';
// import 'package:uuid/uuid.dart';
// import 'room_lobby_screen.dart';
//
// class RoomCreationScreen extends StatelessWidget {
//   const RoomCreationScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController joinController = TextEditingController();
//     return Scaffold(
//       appBar: AppBar(title: Text("Create / Join Room")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               child: Text("Create Room"),
//               onPressed: () {
//                 // Generate a unique ID for current player.
//                 String currentPlayerId = Uuid().v4();
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ChangeNotifierProvider(
//                       create: (_) => RoomController(isHost: true, currentPlayerId: currentPlayerId),
//                       child: RoomLobbyScreen(isHost: true, currentPlayerId: currentPlayerId),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: joinController,
//               decoration: InputDecoration(
//                 labelText: "Enter Room Code",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text("Join Room"),
//               onPressed: () {
//                 String currentPlayerId = Uuid().v4();
//                 // Create a new RoomController for joining (simulate by creating a room and then setting its id)
//                 RoomController roomController =
//                 RoomController(isHost: false, currentPlayerId: currentPlayerId);
//                 // For demo, override room id with entered code.
//                 roomController.joinRoom(joinController.text.toUpperCase(), Player(
//                   id: currentPlayerId,
//                   name: "Player",
//                   role: Role.civilian,
//                 ));
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ChangeNotifierProvider.value(
//                       value: roomController,
//                       child: RoomLobbyScreen(isHost: false, currentPlayerId: currentPlayerId),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// room_creation_screen.dart
// room_creation_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whos_the_imposter/room_controller.dart';
import 'package:whos_the_imposter/models.dart';
import 'package:uuid/uuid.dart';
import 'room_lobby_screen.dart';

class RoomCreationScreen extends StatelessWidget {
  // Optional fixed id for the current player, if you wish to provide one.
  final String? fixedPlayerId;
  const RoomCreationScreen({Key? key, this.fixedPlayerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController joinController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Create / Join Room")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Create Room Flow: Host creates a room.
            ElevatedButton(
              child: const Text("Create Room"),
              onPressed: () {
                // Use fixed id if provided; otherwise, generate a new one.
                String currentPlayerId = fixedPlayerId ?? const Uuid().v4();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => RoomController(isHost: true, currentPlayerId: currentPlayerId),
                      child: RoomLobbyScreen(isHost: true, currentPlayerId: currentPlayerId),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Join Room Flow: Enter a room code to join an existing room.
            TextField(
              controller: joinController,
              decoration: const InputDecoration(
                labelText: "Enter Room Code",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Join Room"),
              onPressed: () {
                String currentPlayerId = fixedPlayerId ?? const Uuid().v4();
                // Instantiate a RoomController for a joining player (non-host)
                RoomController roomController = RoomController(isHost: false, currentPlayerId: currentPlayerId);
                // In this demo, we simulate joining by using the entered code (converted to uppercase)
                // and adding the new player to the room.
                roomController.joinRoom(
                  joinController.text.toUpperCase(),
                  Player(
                    id: currentPlayerId,
                    name: "Player",
                    role: Role.civilian,
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: roomController,
                      child: RoomLobbyScreen(isHost: false, currentPlayerId: currentPlayerId),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


