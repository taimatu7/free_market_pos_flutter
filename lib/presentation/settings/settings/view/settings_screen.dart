import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/components/side_drawer/side_drawer.dart';
import 'package:free_market_pos_flutter/presentation/constants/constants.dart';

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
          title: const Text("設定", style: TextStyle(color: titleColor)),
          backgroundColor: appBarColor,
          centerTitle: true,
        ),
        drawer: const SideDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: const [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Version"),
                  Text("1.0.0"),
                ],
              )
            ],
          ),
        ));
  }
}
