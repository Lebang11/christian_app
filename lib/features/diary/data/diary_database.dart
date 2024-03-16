import 'package:christian_app/features/diary/data/diary.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DiaryDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([DiarySchema], directory: dir.path);
  }

  // list
  final List<diary> currentDiary = [];

  // Create
  Future<void> addDiary(String titleFromUser, textFromUser, dateToday) async {
    final newDiary = diary()
      ..title = titleFromUser
      ..text = textFromUser
      ..date = dateToday;

    await isar.writeTxn(() => isar.diarys.put(newDiary));
  }
  // Read

  Future<void> fetchDiary() async {
    List<diary> fetchedDiaries = await isar.diarys.where().findAll();
    currentDiary.clear();
    currentDiary.addAll(fetchedDiaries);
    notifyListeners();
  }

  // Update

  Future<void> updateDiary(int id, String newText) async {
    final existingDiary = await isar.diarys.get(id);
    if (existingDiary != null) {
      existingDiary.text = newText;
      await isar.writeTxn(() => isar.diarys.put(existingDiary));
      await fetchDiary();
    }
  }

  // Delete
  Future<void> deleteDiary(int id) async {
    await isar.writeTxn(() => isar.diarys.delete(id));
    await fetchDiary();
  }
}
