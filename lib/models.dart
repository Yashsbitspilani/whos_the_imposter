// models.dart

// enum Role { civilian, imposter }
//
// class Player {
//   final String id;
//   String name;
//   Role role;
//   bool eliminated;
//   String word;
//
//   Player({
//     required this.id,
//     required this.name,
//     required this.role,
//     this.eliminated = false,
//     this.word = '',
//   });
// }
//
// class Room {
//   late final String id;
//   List<Player> players;
//   List<String> clues;
//   int roundNumber;
//   String status; // "waiting", "started", "finished"
//   Map<String, int> votes;
//
//   Room({
//     required this.id,
//     required this.players,
//     required this.clues,
//     required this.roundNumber,
//     required this.status,
//     required this.votes,
//   });
// }

enum Role { civilian, imposter }

class Player {
  final String id;
  String name;
  Role role;
  bool eliminated;
  String word;

  Player({
    required this.id,
    required this.name,
    required this.role,
    this.eliminated = false,
    this.word = '',
  });
}

class Room {
  late final String id;
  List<Player> players;
  List<String> clues;
  int roundNumber;
  String status; // "waiting", "started", "finished"
  Map<String, int> votes;

  Room({
    required this.id,
    required this.players,
    required this.clues,
    required this.roundNumber,
    required this.status,
    required this.votes,
  });
}

/// A class representing a pair of words: one for civilians and one for the imposter.
/// This class encapsulates the pair so that later you can assign
/// each player their secret word without revealing whether it's for the civilian or the imposter.
class WordPair {
  final String civilian;
  final String imposter;

  const WordPair({
    required this.civilian,
    required this.imposter,
  });

  /// Returns the appropriate word for the given role.
  String wordFor(Role role) {
    return role == Role.imposter ? imposter : civilian;
  }
}

/// A constant list of word pairs. You can add as many pairs as you like.
/// Each pair contains two words that are similar but different, keeping the challenge subtle.
const List<WordPair> wordPairs = [
  WordPair(civilian: 'Apple', imposter: 'Pineapple'),
  WordPair(civilian: 'Dog', imposter: 'Wolf'),
  WordPair(civilian: 'Beach', imposter: 'Desert'),
  // Add more pairs as needed.
];

