import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/history/history/view/history_screen.dart';
import 'package:free_market_pos_flutter/presentation/registration/category/category_screen.dart';
import 'package:free_market_pos_flutter/presentation/registration/product/product_screen.dart';
import 'package:free_market_pos_flutter/presentation/sale/sale/view/sale_screen.dart';
import 'package:free_market_pos_flutter/presentation/settings/settings/view/settings_screen.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);
  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '画面一覧',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('商品販売'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SaleScreen(
                  paied: false,
                );
              }));
            },
          ),
          ListTile(
            title: const Text('商品販売履歴'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HistoryScreen();
              }));
            },
          ),
          ListTile(
            title: const Text('カテゴリー編集'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CategoryScreen();
              }));
            },
          ),
          ListTile(
            title: const Text('商品編集'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ProductScreen();
              }));
            },
          ),
          ListTile(
            title: const Text('設定'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SettingsScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}
