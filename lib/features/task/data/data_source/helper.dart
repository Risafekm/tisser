// core/local/task_cache.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tisser_app/features/task/domain/entities/task_entities.dart';

class TaskCache {
  static const String _cacheKey = 'cached_tasks';

  Future<void> saveTasks(List<TaskEntity> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> tasksJson =
        tasks.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(_cacheKey, tasksJson);
  }

  Future<List<TaskEntity>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? tasksJson = prefs.getStringList(_cacheKey);
    if (tasksJson == null) return [];
    return tasksJson
        .map((taskStr) => TaskEntity.fromJson(jsonDecode(taskStr)))
        .toList();
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
