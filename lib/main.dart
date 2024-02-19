import 'package:flutter/material.dart';
import 'home_screen.dart'; // Убедитесь, что вы создали этот файл

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        // Основная светлая тема
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        // Темная тема
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      themeMode:
          ThemeMode.system, // Использует тему, выбранную в системных настройках
      home: HomeScreen(), // Экран по умолчанию
    );
  }
}
