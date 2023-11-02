import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'main/components/navigation.dart';
import 'main/model/data_model.dart';

late Box noteBox;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  noteBox = await Hive.openBox<Note>('noteBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const NavigationManager(),
    );
  }
}
