import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/components/side_drawer/side_drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      drawer: const SideDrawer(),
      body: const Center(
        child: Text("SettingsScreen"),
      ),
    );
  }
}
