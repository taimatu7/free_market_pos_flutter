import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/extensions/context_extension.dart';
import '../../../constants/constants.dart';
import '../../../sale/sale/view/sale_screen.dart';
import '../view_model/store_screen_model.dart';
import '../view_model/store_screen_view_model.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  final TextEditingController _storeNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen<StoreScreenModel>(storeScreenViewModelProvider, (previous, next) {
      if (next.registered) {
        context.showSnackBar('店舗登録に成功しました。');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SaleScreen(
            paied: false,
          );
        }));
      } else {
        context.showSnackBar('店舗登録に失敗しました。もう一度登録してください。');
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('店舗登録', style: TextStyle(color: titleColor)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(screenPaddingSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('店舗名を入力してください。', style: TextStyle(fontSize: inputLabelFontSizeStore)),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _storeNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '店舗名',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () async {
                    await ref.read(storeScreenViewModelProvider.notifier).registerStore(_storeNameController.text);
                  },
                  child: const Text('登録', style: TextStyle(color: bottonTextColor, fontSize: buttonFontSizeStore)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
