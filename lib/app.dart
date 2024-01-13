import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/other/application/view/application_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FreeMarketPos",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ApplicationScreen(),
    );
  }
}
