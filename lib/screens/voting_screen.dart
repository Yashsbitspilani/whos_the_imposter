// // voting_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:whos_the_imposter/models.dart';
// import 'package:whos_the_imposter/room_controller.dart';
//
// class VotingScreen extends StatelessWidget {
//   const VotingScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final roomController = Provider.of<RoomController>(context);
//     return Scaffold(
//       appBar: AppBar(title: Text("Voting Round - Round ${roomController.room.roundNumber}")),
//       body: ListView.builder(
//         itemCount: roomController.room.players.length,
//         itemBuilder: (context, index) {
//           final player = roomController.room.players[index];
//           return ListTile(
//             leading: Icon(Icons.person),
//             title: Text(player.name),
//             onTap: () {
//               roomController.recordVote(player.id);
//               ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Voted for ${player.name}")));
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.how_to_vote),
//         onPressed: () {
//           final eliminated = roomController.completeVoting();
//           if (eliminated != null) {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text("Player Eliminated"),
//                   content: Text("${eliminated.name} was eliminated.\nThey were a ${eliminated.role == Role.imposter ? "Imposter" : "Civilian"}."),
//                   actions: [
//                     TextButton(
//                       child: Text("OK"),
//                       onPressed: () {
//                         Navigator.pop(context);
//                         if (eliminated.id == roomController.currentPlayerId) {
//                           // If you're eliminated, return to the lobby.
//                           Navigator.pushReplacementNamed(context, '/lobby');
//                         } else {
//                           // Otherwise, for continuing players, start next round.
//                           Navigator.pushReplacementNamed(context, '/secret');
//                         }
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whos_the_imposter/models.dart';
import 'package:whos_the_imposter/room_controller.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({Key? key}) : super(key: key);

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
          appBar: AppBar(
              title: Text(
                  "Voting Round - Round ${roomController.room!.roundNumber}")),
          body: ListView.builder(
            itemCount: roomController.room!.players.length,
            itemBuilder: (context, index) {
              final player = roomController.room!.players[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(player.name),
                onTap: () {
                  roomController.recordVote(player.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Voted for ${player.name}")));
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.how_to_vote),
            onPressed: () {
              final eliminated = roomController.completeVoting();
              if (eliminated != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Player Eliminated"),
                      content: Text(
                          "${eliminated.name} was eliminated.\nThey were a ${eliminated.role == Role.imposter ? "Imposter" : "Civilian"}."),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                            if (eliminated.id == roomController.currentPlayerId) {
                              // If you're eliminated, return to the lobby.
                              Navigator.pushReplacementNamed(context, '/lobby');
                            } else {
                              // Otherwise, for continuing players, start next round.
                              Navigator.pushReplacementNamed(context, '/secret');
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
