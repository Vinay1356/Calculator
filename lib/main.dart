import 'package:calculator_app/screens/calculator_screen.dart';
import 'package:calculator_app/providers/theme_changer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeChanger = Provider.of<ThemeChanger>(context);
    return MultiProvider(
        providers: [ChangeNotifierProvider(
            create: (_) => ThemeChanger())
        ],
        child: Builder(builder: (BuildContext context) {
          final themeChanger = Provider.of<ThemeChanger>(context);
          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            themeMode: themeChanger.themeMode,
            home: const CalculatorApp(),
          );
        }));
  }
}
