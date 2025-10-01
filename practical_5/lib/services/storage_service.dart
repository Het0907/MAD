import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practical_5/models/resume.dart';

class StorageService {
  static const String _resumeKey = 'saved_resumes';

  static Future<void> saveResume(Resume resume, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final savedResumes = await getSavedResumes();
    savedResumes[id] = resume.toJson();
    await prefs.setString(_resumeKey, jsonEncode(savedResumes));
  }

  static Future<Resume?> loadResume(String id) async {
    final savedResumes = await getSavedResumes();
    if (savedResumes.containsKey(id)) {
      return Resume.fromJson(savedResumes[id]);
    }
    return null;
  }

  static Future<Map<String, dynamic>> getSavedResumes() async {
    final prefs = await SharedPreferences.getInstance();
    final resumesJson = prefs.getString(_resumeKey);
    if (resumesJson != null) {
      return Map<String, dynamic>.from(jsonDecode(resumesJson));
    }
    return {};
  }

  static Future<List<String>> getResumeIds() async {
    final savedResumes = await getSavedResumes();
    return savedResumes.keys.toList();
  }

  static Future<void> deleteResume(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final savedResumes = await getSavedResumes();
    savedResumes.remove(id);
    await prefs.setString(_resumeKey, jsonEncode(savedResumes));
  }

  static Future<void> clearAllResumes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_resumeKey);
  }
}