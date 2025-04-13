// description_round_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whos_the_imposter/room_controller.dart';

// class DescriptionRoundScreen extends StatefulWidget {
//   const DescriptionRoundScreen({Key? key}) : super(key: key);
//
//   @override
//   _DescriptionRoundScreenState createState() => _DescriptionRoundScreenState();
// }
//
// class _DescriptionRoundScreenState extends State<DescriptionRoundScreen> {
//   final TextEditingController _clueController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final roomController = Provider.of<RoomController>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Round ${roomController.room.roundNumber} - Submit Clue'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text("Enter your clue for your secret word:", style: TextStyle(fontSize: 18)),
//             TextField(
//               controller: _clueController,
//               decoration: InputDecoration(hintText: "Type your clue here..."),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (_clueController.text.isNotEmpty) {
//                   roomController.addClue(_clueController.text, roomController.currentPlayerId);
//                   _clueController.clear();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Clue submitted.")));
//                 }
//               },
//               child: Text("Submit Clue"),
//             ),
//             SizedBox(height: 30),
//             Text("Clues so far:", style: TextStyle(fontSize: 18)),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: roomController.room.clues.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(roomController.room.clues[index]),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // For demonstration, press this button to end the round and go to voting.
//                 Navigator.pushReplacementNamed(context, '/voting');
//               },
//               child: Text("End Round & Vote (if two rounds complete)"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _clueController.dispose();
//     super.dispose();
//   }
// }


class DescriptionRoundScreen extends StatefulWidget {
  const DescriptionRoundScreen({Key? key}) : super(key: key);

  @override
  _DescriptionRoundScreenState createState() => _DescriptionRoundScreenState();
}

class _DescriptionRoundScreenState extends State<DescriptionRoundScreen> {
  final TextEditingController _clueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomController>(
      builder: (context, roomController, child) {
        // Wait until the room is initialized.
        if (roomController.room == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Loading...')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title:
            Text('Round ${roomController.room!.roundNumber} - Submit Clue'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text("Enter your clue for your secret word:",
                    style: TextStyle(fontSize: 18)),
                TextField(
                  controller: _clueController,
                  decoration:
                  const InputDecoration(hintText: "Type your clue here..."),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_clueController.text.isNotEmpty) {
                      roomController.addClue(
                          _clueController.text, roomController.currentPlayerId);
                      _clueController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Clue submitted.")));
                    }
                  },
                  child: const Text("Submit Clue"),
                ),
                const SizedBox(height: 30),
                const Text("Clues so far:", style: TextStyle(fontSize: 18)),
                Expanded(
                  child: ListView.builder(
                    itemCount: roomController.room!.clues.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(roomController.room!.clues[index]),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // For demonstration, press this button to end the round and go to voting.
                    Navigator.pushReplacementNamed(context, '/voting');
                  },
                  child: const Text("End Round & Vote (if two rounds complete)"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _clueController.dispose();
    super.dispose();
  }
}
