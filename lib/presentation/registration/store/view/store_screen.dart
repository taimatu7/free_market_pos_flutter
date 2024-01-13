import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/constants/constants.dart';
import 'package:free_market_pos_flutter/presentation/sale/sale/view/sale_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);
  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text("店舗登録", style: TextStyle(color: titleColor)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(screenPaddingSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("店舗名を入力してください。",
                  style: TextStyle(fontSize: inputLabelFontSizeStore)),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SaleScreen();
                    }));
                  },
                  child: const Text("登録",
                      style: TextStyle(
                          color: bottonTextColor,
                          fontSize: buttonFontSizeStore)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
