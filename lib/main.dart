import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:git_parties/materials/language_provider.dart';

import 'package:git_parties/screens/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => LanguageProvider()), // LanguageProviderを追加
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ディレクトリを構成するために使用
    return MaterialApp(
      title: 'Git Parties',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
