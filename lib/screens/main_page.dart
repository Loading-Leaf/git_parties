import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:git_parties/materials/color_settting.dart';
import 'package:git_parties/screens/repogitories_specific.dart';

import 'package:http/http.dart' as http; //Github APIを使用するために必要なパッケージ

import "package:git_parties/materials/language_provider.dart"; //言語設定するためのファイル
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GitHub APIから取得したリポジトリのデータを格納するための変数
  List<dynamic> _repositories = [];
  bool _isLoading = false;
  String _sortCriterion = 'stars'; // 並び替え基準
  bool _isDescending = true; // 降順かどうかを判定

  // 検索ボタンが押されたときに呼ばれるメソッド
  Future<void> _searchRepositories(String query) async {
    setState(() {
      _isLoading = true;
    });

    final url =
        Uri.parse('https://api.github.com/search/repositories?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _repositories = data['items'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load repositories');
    }
  }

  // 並び替え基準を変更するメソッド
  void _sortRepositories() {
    setState(() {
      _repositories.sort((a, b) {
        final aValue = _sortCriterion == 'stars'
            ? a['stargazers_count']
            : _sortCriterion == 'forks'
                ? a['forks_count']
                : a['watchers_count'];
        final bValue = _sortCriterion == 'stars'
            ? b['stargazers_count']
            : _sortCriterion == 'forks'
                ? b['forks_count']
                : b['watchers_count'];

        return _isDescending
            ? bValue.compareTo(aValue)
            : aValue.compareTo(bValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final titlebarColor = getAppBarColor(); // メソッドの結果を変数に格納
    final titleTextColor = getTitleTextColor(); // メソッドの結果を変数に格納
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Git Parties',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: titleTextColor,
          ),
        ),
        backgroundColor: titlebarColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.language,
              color: titleTextColor,
            ),
            onPressed: () {
              // 言語を切り替える処理
              languageProvider.isJapanese
                  ? languageProvider.setLanguage(false)
                  : languageProvider.setLanguage(true);
            },
            tooltip: languageProvider.isJapanese
                ? '言語を英語に切り替える'
                : 'Switch to Japanese',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                languageProvider.isJapanese == true
                    ? 'Githubのリポジトリを検索してみましょう！'
                    : "Let's search for GitHub repositories!",
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: languageProvider.isJapanese == true
                      ? '検索してください'
                      : "Search",
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onSubmitted: (query) {
                  _searchRepositories(query);
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: _sortCriterion,
                    items: [
                      DropdownMenuItem(
                        value: 'stars',
                        child: Text(languageProvider.isJapanese == true
                            ? 'スター数'
                            : 'Stars'),
                      ),
                      DropdownMenuItem(
                        value: languageProvider.isJapanese == true
                            ? 'フォーク数'
                            : 'forks',
                        child: Text('Forks'),
                      ),
                      DropdownMenuItem(
                        value: 'watchers',
                        child: Text(languageProvider.isJapanese == true
                            ? 'ウォッチ数'
                            : 'Watchers'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _sortCriterion = value;
                        });
                        _sortRepositories();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      _isDescending ? Icons.arrow_downward : Icons.arrow_upward,
                    ),
                    onPressed: () {
                      setState(() {
                        _isDescending = !_isDescending;
                      });
                      _sortRepositories();
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              _isLoading
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _repositories.length,
                        itemBuilder: (context, index) {
                          final repo = _repositories[index];
                          return ListTile(
                            title: Text(repo['name']),
                            subtitle: Text(repo['html_url']),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      // リポジトリの詳細ページに遷移
                                      Repogitory_Page(
                                    data: repo,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
