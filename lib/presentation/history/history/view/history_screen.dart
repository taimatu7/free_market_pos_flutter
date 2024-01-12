import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/components/side_drawer/side_drawer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('販売履歴'),
      ),
      drawer: const SideDrawer(),
      body: const Center(
        child: Text("HistoryScreen"),
      ),
    );
  }
}
