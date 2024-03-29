import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/extensions/context_extension.dart';
import '../../../components/side_drawer/view/side_drawer.dart';
import '../../../constants/constants.dart';
import '../view_model/settings_screen_model.dart';
import '../view_model/settings_screen_view_model.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _storeNameController = TextEditingController();
  late Future<void> _initFunction;

  @override
  void initState() {
    super.initState();
    _initFunction = _init();
  }

  Future<void> _init() async {
    final notifier = ref.read(settingsScreenViewModelProvider.notifier);
    await notifier.init();
  }

  @override
  Widget build(BuildContext context) {
    String storeName;
    ref.listen<SettingsScreenModel>(settingsScreenViewModelProvider, (previous, next) {
      setState(() {
        storeName = next.store?.name ?? '';
      });
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('設定', style: TextStyle(color: titleColor)),
            backgroundColor: appBarColor,
            centerTitle: true,
          ),
          drawer: const SideDrawer(),
          body: FutureBuilder(
              future: _initFunction,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) const Center(child: CircularProgressIndicator());
                final model = ref.read(settingsScreenViewModelProvider);
                storeName = model.store?.name ?? '';

                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [const Text('店舗名'), Text(storeName ?? '店舗名が取得できませんでした')],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Version'),
                            Text(model.version ?? 'バージョン情報が取得できませんでした'),
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
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                ),
                                onPressed: () {
                                  _storeNameController.text = storeName;
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: const Text('店舗名を変更'),
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
                                              onPressed: () async {
                                                await ref.read(settingsScreenViewModelProvider.notifier).updateStore(_storeNameController.text);
                                                if (mounted) {
                                                  context.showSnackBar('店舗名を変更しました');
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text('Save'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Text('店舗名変更', style: TextStyle(color: bottonTextColor))))
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
