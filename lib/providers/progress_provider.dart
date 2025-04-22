import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProgressProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  final Set<String> completedExerciseIds = {};

  int exercisesCompleted = 0;
  int quizzesCompleted = 0;
  int diamonds = 0;
  int gold = 0;
  int silver = 0;
  int bronze = 0;

  ProgressProvider() {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final data = await _storage.read(key: "progress");
    if (data != null) {
      final decoded = jsonDecode(data);
      exercisesCompleted = decoded["exercisesCompleted"] ?? 0;
      quizzesCompleted = decoded["quizzesCompleted"] ?? 0;
      diamonds = decoded["diamonds"] ?? 0;

      final trophies = decoded["trophies"] ?? {};
      gold = trophies["gold"] ?? 0;
      silver = trophies["silver"] ?? 0;
      bronze = trophies["bronze"] ?? 0;
    }
    notifyListeners();
  }

  Future<void> _saveToStorage() async {
    final data = {
      "exercisesCompleted": exercisesCompleted,
      "quizzesCompleted": quizzesCompleted,
      "diamonds": diamonds,
      "trophies": {
        "gold": gold,
        "silver": silver,
        "bronze": bronze,
      }
    };
    await _storage.write(key: "progress", value: jsonEncode(data));
  }

  void completeExercise() {
    exercisesCompleted++;
    _saveToStorage();
    notifyListeners();
  }

  void completeQuiz() {
    quizzesCompleted++;
    _saveToStorage();
    notifyListeners();
  }

  void addDiamonds(int amount) {
    diamonds += amount;
    _saveToStorage();
    notifyListeners();
  }

  void markExerciseCompleted(String id) {
  if (!completedExerciseIds.contains(id)) {
    completedExerciseIds.add(id);
    exercisesCompleted++;
    addDiamonds(10);
    _saveToStorage();
    notifyListeners();
  }
}

  void awardTrophy(String type) {
    if (type == "gold") gold++;
    if (type == "silver") silver++;
    if (type == "bronze") bronze++;
    _saveToStorage();
    notifyListeners();
  }

  Future<void> loadFromBackend() async {
    final token = await _storage.read(key: "token");
    if (token == null) return;

    final response = await http.get(
      Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/user/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      exercisesCompleted = data["exercisesCompleted"] ?? 0;
      quizzesCompleted = data["quizzesCompleted"] ?? 0;
      diamonds = data["diamonds"] ?? 0;

      final trophies = data["trophies"] ?? {};
      gold = trophies["gold"] ?? 0;
      silver = trophies["silver"] ?? 0;
      bronze = trophies["bronze"] ?? 0;

      await _saveToStorage();
      notifyListeners();
    } else {
      debugPrint("Failed to load progress from backend: ${response.body}");
    }
  }

  Future<void> syncToBackend() async {
    final token = await _storage.read(key: "token");
    if (token == null) return;

    final response = await http.post(
      Uri.parse("https://your-backend.com/api/v1/user/progress"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "exercisesCompleted": exercisesCompleted,
        "quizzesCompleted": quizzesCompleted,
        "diamonds": diamonds,
        "trophies": {
          "gold": gold,
          "silver": silver,
          "bronze": bronze,
        }
      }),
    );

    if (response.statusCode == 200) {
      debugPrint("Progress synced successfully");
    } else {
      debugPrint("Failed to sync progress: ${response.body}");
    }
  }

  void reset() {
    exercisesCompleted = 0;
    quizzesCompleted = 0;
    diamonds = 0;
    gold = 0;
    silver = 0;
    bronze = 0;
    _saveToStorage();
    notifyListeners();
  }
}
