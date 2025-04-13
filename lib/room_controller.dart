// room_controller.dart
import 'package:flutter/material.dart';
import 'models.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import 'package:collection/collection.dart';

// class RoomController extends ChangeNotifier {
//   late Room _room;
//   Room get room => _room;
//
//   final bool isHost;
//   final String _currentPlayerId;
//   String get currentPlayerId => _currentPlayerId;
//
//   RoomController({required this.isHost, required String currentPlayerId})
//       : _currentPlayerId = currentPlayerId {
//     if (isHost) {
//       createRoom();
//     }
//   }
//
//   // Create a new room (host only)
//   void createRoom() {
//     String roomId = Uuid().v4().substring(0, 6).toUpperCase();
//     _room = Room(
//       id: roomId,
//       players: [],
//       clues: [],
//       roundNumber: 1,
//       status: 'waiting',
//       votes: {},
//     );
//     // Add host to the room.
//     addPlayer(Player(
//       id: currentPlayerId,
//       name: "Host",
//       role: Role.civilian, // role will be assigned in startGame()
//     ));
//   }
//
//   // Simulate joining a room (for demo, we assume the room already exists)
//   void joinRoom(String roomId, Player newPlayer) {
//     // In a real app, you’d lookup the room by roomId.
//     _room = Room(
//       id: roomId,
//       players: [],
//       clues: [],
//       roundNumber: 1,
//       status: 'waiting',
//       votes: {},
//     );
//     addPlayer(newPlayer);
//   }
//
//   // Add a player to the room.
//   void addPlayer(Player player) {
//     _room.players.add(player);
//     notifyListeners();
//   }
//
//   // Start the game by assigning roles and words.
//   void startGame() {
//     _room.status = 'started';
//     assignRolesAndWords();
//     notifyListeners();
//   }
//
//   // Randomly choose one imposter and assign words from a set of word pairs.
//   void assignRolesAndWords() {
//     final random = Random();
//     if (_room.players.isNotEmpty) {
//       int imposterIndex = random.nextInt(_room.players.length);
//       final wordPairs = [
//         {'civilian': 'Apple', 'imposter': 'Pineapple'},
//         {'civilian': 'Dog', 'imposter': 'Wolf'},
//         {'civilian': 'Beach', 'imposter': 'Desert'},
//       ];
//       final selectedPair = wordPairs[random.nextInt(wordPairs.length)];
//
//       for (int i = 0; i < _room.players.length; i++) {
//         if (i == imposterIndex) {
//           _room.players[i].role = Role.imposter;
//           _room.players[i].word = selectedPair['imposter']!;
//         } else {
//           _room.players[i].role = Role.civilian;
//           _room.players[i].word = selectedPair['civilian']!;
//         }
//       }
//     }
//   }
//
//   // Add a clue from a player; clues are stored with the player's id.
//   void addClue(String clue, String playerId) {
//     _room.clues.add("$playerId: $clue");
//     notifyListeners();
//   }
//
//   // Record a vote in the current round.
//   void recordVote(String votedPlayerId) {
//     _room.votes.update(votedPlayerId, (value) => value + 1, ifAbsent: () => 1);
//     notifyListeners();
//   }
//
//   // Complete voting round, eliminate the player with the highest votes,
//   // clear clues and votes, and increment the round number.
//   // Returns the eliminated player.
//   Player? completeVoting() {
//     if (_room.votes.isEmpty) return null;
//     String eliminatedId =
//         _room.votes.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
//     Player? eliminated =
//     _room.players.firstWhereOrNull((p) => p.id == eliminatedId);
//     if(eliminated == null){
//       return null;
//     }
//     _room.players.remove(eliminated);
//     _room.clues.clear();
//     _room.votes.clear();
//     _room.roundNumber++;
//     notifyListeners();
//     return eliminated;
//   }
// }


class RoomController extends ChangeNotifier {
  // Make _room nullable until initialized.
  Room? _room;
  Room? get room => _room;

  final bool isHost;
  final String _currentPlayerId;
  String get currentPlayerId => _currentPlayerId;

  RoomController({required this.isHost, required String currentPlayerId})
      : _currentPlayerId = currentPlayerId {
    if (isHost) {
      createRoom();
    }
  }

  // Create a new room (host only)
  void createRoom() {
    String roomId = Uuid().v4().substring(0, 6).toUpperCase();
    _room = Room(
      id: roomId,
      players: [],
      clues: [],
      roundNumber: 1,
      status: 'waiting',
      votes: {},
    );
    // Add host to the room.
    addPlayer(Player(
      id: _currentPlayerId,
      name: "Host",
      role: Role.civilian, // role will be assigned in startGame()
    ));

    // Notify listeners that the room has been initialized.
    notifyListeners();
  }

  // Simulate joining a room (for demo, we assume the room already exists)
  void joinRoom(String roomId, Player newPlayer) {
    // Initialize _room if it hasn't been initialized yet.
    _room ??= Room(
      id: roomId,
      players: [],
      clues: [],
      roundNumber: 1,
      status: 'waiting',
      votes: {},
    );
    addPlayer(newPlayer);
  }

  // Add a player to the room.
  void addPlayer(Player player) {
    // It is safe to use _room! since we initialize _room before adding a player.
    _room!.players.add(player);
    notifyListeners();
  }

  // Start the game by assigning roles and words.
  void startGame() {
    if (_room == null) return;
    _room!.status = 'started';
    assignRolesAndWords();
    notifyListeners();
  }

  // Randomly choose one imposter and assign words from a set of word pairs.
  // void assignRolesAndWords() {
  //   if (_room == null || _room!.players.isEmpty) return;
  //   final random = Random();
  //   int imposterIndex = random.nextInt(_room!.players.length);
  //   final wordPairs = [
  //     {'civilian': 'Apple', 'imposter': 'Pineapple'},
  //     {'civilian': 'Dog', 'imposter': 'Wolf'},
  //     {'civilian': 'Beach', 'imposter': 'Desert'},
  //   ];
  //   final selectedPair = wordPairs[random.nextInt(wordPairs.length)];
  //
  //   for (int i = 0; i < _room!.players.length; i++) {
  //     if (i == imposterIndex) {
  //       _room!.players[i].role = Role.imposter;
  //       _room!.players[i].word = selectedPair['imposter']!;
  //     } else {
  //       _room!.players[i].role = Role.civilian;
  //       _room!.players[i].word = selectedPair['civilian']!;
  //     }
  //   }
  // }

  void assignRolesAndWords() {
    if (_room == null || _room!.players.isEmpty) return;
    final random = Random();

    // Pick the imposter index.
    int imposterIndex = random.nextInt(_room!.players.length);

    // Use the imported word pairs from models.dart.
    final selectedPair = wordPairs[random.nextInt(wordPairs.length)];

    // Assign roles and corresponding secret words using the wordFor helper method.
    for (int i = 0; i < _room!.players.length; i++) {
      final role = i == imposterIndex ? Role.imposter : Role.civilian;
      _room!.players[i].role = role;
      _room!.players[i].word = selectedPair.wordFor(role);
    }
  }


  // Add a clue from a player; clues are stored with the player's id.
  void addClue(String clue, String playerId) {
    _room!.clues.add("$playerId: $clue");
    notifyListeners();
  }

  // Record a vote in the current round.
  void recordVote(String votedPlayerId) {
    _room!.votes.update(votedPlayerId, (value) => value + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  // Complete voting round, eliminate the player with the highest votes,
  // clear clues and votes, and increment the round number.
  // Returns the eliminated player.
  Player? completeVoting() {
    if (_room == null || _room!.votes.isEmpty) return null;
    String eliminatedId =
        _room!.votes.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    // Using collection package's firstWhereOrNull method (ensure the dependency exists)
    Player? eliminated = _room!.players.firstWhereOrNull((p) => p.id == eliminatedId);
    if (eliminated == null) {
      return null;
    }
    _room!.players.remove(eliminated);
    _room!.clues.clear();
    _room!.votes.clear();
    _room!.roundNumber++;
    notifyListeners();
    return eliminated;
  }
}




