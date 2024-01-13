import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/constants/constants.dart';
import 'package:free_market_pos_flutter/presentation/registration/store/view/store_screen.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({Key? key}) : super(key: key);
  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const StoreScreen();
      }));
    });
    return Scaffold(
        body: Container(
            color: Colors.blue,
            width: double.infinity,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'フリマPOS',
                  style: TextStyle(
                      color: textColorApplication,
                      fontSize: titleFontSizeApplication),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'アプリ起動中...',
                  style: TextStyle(
                      color: textColorApplication,
                      fontSize: subTitleFontSizeApplication),
                ),
              ],
            )));
  }
}
