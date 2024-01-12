import 'package:flutter/material.dart';
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
    return Container(
      color: Colors.white,
      child: const Center(child: Text('ApplicationScreen')),
    );
  }
}
