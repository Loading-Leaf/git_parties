import 'package:flutter/material.dart';

// AppBarの色に対応して文字色を変更する
Color getTitleTextColor() {
  // アンダースコアを削除してパブリック関数に変更
  final hour = DateTime.now().hour;
  if (hour >= 6 && hour < 21) {
    // 朝から夕方まで
    return const Color.fromARGB(255, 0, 0, 0);
  } else {
    // 夜
    return const Color.fromARGB(255, 255, 255, 255);
  }
}

// AppBarの色を時間帯によって変更する
Color getAppBarColor() {
  // アンダースコアを削除してパブリック関数に変更
  final hour = DateTime.now().hour;
  if (hour >= 6 && hour < 12) {
    // 朝から夕方まで
    return const Color.fromARGB(255, 124, 210, 249);
  } else if (hour >= 12 && hour < 18) {
    // 朝から夕方まで
    return const Color.fromARGB(255, 0, 174, 255);
  } else if (hour >= 18 && hour < 21) {
    // 朝から夕方まで
    return const Color.fromARGB(255, 255, 174, 0);
  } else {
    // 夜
    return const Color.fromARGB(255, 0, 4, 67);
  }
}
