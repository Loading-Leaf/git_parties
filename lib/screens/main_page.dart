import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:git_parties/materials/color_settting.dart';
import 'package:git_parties/screens/repogitories_specific.dart';

import 'package:http/http.dart' as http; //Github APIを使用するために必要なパッケージ

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GitHub APIから取得したリポジトリのデータを格納するための変数
  List<dynamic> _repositories = [];
  bool _isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    final titlebarColor = getAppBarColor(); // メソッドの結果を変数に格納
    final titleTextColor = getTitleTextColor(); // メソッドの結果を変数に格納
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Githubのリポジトリを検索してみましょう！',
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search Repositories',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (query) {
                  _searchRepositories(query);
                },
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
