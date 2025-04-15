import 'package:flutter/material.dart';
import 'package:git_parties/materials/color_settting.dart';

import "package:git_parties/materials/language_provider.dart"; //言語設定するためのファイル
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart'; // url_launcherのインポート

class Repogitory_Page extends StatefulWidget {
  final Map<String, dynamic> data;
  const Repogitory_Page({super.key, required this.data});

  @override
  State<Repogitory_Page> createState() => _Repogitory_PageState();
}

class _Repogitory_PageState extends State<Repogitory_Page> {
  late String repogitory_name; // リポジトリ名
  late String language; // リポジトリのプログラミング言語
  late int star_count; // リポジトリのスター数
  late int watcher_count; // リポジトリのウォッチャー数
  late int fork_count; // リポジトリのフォーク数
  late int issue_count; // リポジトリのイシュー数
  late String owner_avatar_url; // オーナーのアイコンURL
  late String git_url; // GitHubのURL

  @override
  void initState() {
    super.initState();
    repogitory_name = widget.data["name"];
    language =
        widget.data["language"] ?? "Unknown"; // プログラミング言語がnullの場合は"Unknown"を代入
    star_count = widget.data["stargazers_count"];
    watcher_count = widget.data["watchers_count"];
    fork_count = widget.data["forks_count"];
    issue_count = widget.data["open_issues_count"];
    owner_avatar_url = widget.data["owner"]["avatar_url"]; // オーナーのアイコンURLを取得
    git_url = widget.data["html_url"]; // GitHubのURLを取得
  }

  @override
  Widget build(BuildContext context) {
    final titlebarColor = getAppBarColor(); // メソッドの結果を変数に格納
    final titleTextColor = getTitleTextColor(); // メソッドの結果を変数に格納
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // 戻るアイコン
          color: titleTextColor, // アイコンの色
          onPressed: () {
            Navigator.pop(context); // 前の画面に戻る
          },
        ),
        title: Text(
          'Git Parties',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: titleTextColor,
          ),
        ),
        backgroundColor: titlebarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(owner_avatar_url), // オーナーのアイコンを表示
                    radius: 40,
                  ),
                  SizedBox(width: 16),
                  // リポジトリ名を表示
                  Text(
                    repogitory_name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                languageProvider.isJapanese == true
                    ? 'プログラミング言語: $language'
                    : 'Language: $language',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              // リポジトリのプログラミング言語を表示
              Text(
                languageProvider.isJapanese == true
                    ? 'スター数: $star_count'
                    : 'Stars: $star_count',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              // リポジトリのスター数を表示
              Text(
                languageProvider.isJapanese == true
                    ? '閲覧数: $watcher_count'
                    : 'Watchers: $watcher_count',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              // リポジトリのフォーク数を表示
              Text(
                languageProvider.isJapanese == true
                    ? 'フォーク数: $fork_count'
                    : 'Forks: $fork_count',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              // リポジトリのイシュー数を表示
              Text(
                languageProvider.isJapanese == true
                    ? 'イシュー数: $issue_count'
                    : 'Open Issues: $issue_count',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  launchUrl(Uri.parse(git_url)); // GitHubのURLを開く
                },
                child: Text(
                  languageProvider.isJapanese == true
                      ? "Githubを開く"
                      : 'Open on GitHub',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: titleTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
