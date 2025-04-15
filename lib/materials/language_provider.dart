import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class LanguageProvider with ChangeNotifier {
  bool _isJapanese = true;
  bool get isJapanese => _isJapanese;

  LanguageProvider() {
    _loadLanguage(); // 初期化時に設定を読み込む
    notifyListeners();
    _initializeLanguage();
  }

  // 言語の初期化（デバイスの言語を考慮）
  Future<void> _initializeLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    // 初回起動チェック（`locallanguage` が未設定ならデバイス言語を適用）
    if (!prefs.containsKey('isJapanese')) {
      String deviceLanguage = window.locale.languageCode; // デバイスの言語取得
      _isJapanese = (deviceLanguage == 'ja') ? true : false; // 英語なら2、日本語なら1
      await prefs.setBool('isJapanese', _isJapanese); // 初回のみ保存
    } else {
      _isJapanese = prefs.getBool('isJapanese') ?? true; // 既存の設定を適用
    }
    notifyListeners();
  }

  // 言語を変更する
  void setLanguage(bool isJapanese) async {
    _isJapanese = isJapanese;
    notifyListeners(); // UI を更新
    _saveLanguage(isJapanese); // 設定を保存
  }

  // 設定を保存
  Future<void> _saveLanguage(bool isJapanese) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isJapanese', isJapanese);
  }

  // 設定を読み込む
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _isJapanese = prefs.getBool('isJapanese') ?? true; // デフォルトはひらがな
    notifyListeners();
  }
}
