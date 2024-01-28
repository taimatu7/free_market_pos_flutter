import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/components/side_drawer/view/side_drawer.dart';
import 'package:free_market_pos_flutter/presentation/constants/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _storeNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _storeNameController.text = "test店";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("設定", style: TextStyle(color: titleColor)),
          backgroundColor: appBarColor,
          centerTitle: true,
        ),
        drawer: const SideDrawer(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("店舗名"), Text("test店")],
                ),
                const Divider(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Version"),
                    Text("1.0.0"),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text("店舗名を変更"),
                                  content: TextField(
                                    controller: _storeNameController,
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      labelText: '店舗名',
                                      hintText: '店舗名を入力してください',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Save'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text("店舗名変更",
                            style: TextStyle(color: bottonTextColor))))
              ],
            ),
          ),
        ));
  }
}
