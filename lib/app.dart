import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

import 'infrastructure/data/db/store.dart';
import 'infrastructure/data/db/test_seeder.dart';
import 'infrastructure/providers/repository_provider.dart';
import 'infrastructure/repositories/category/category_repository_impl.dart';
import 'infrastructure/repositories/store/store_repository_impl.dart';
import 'presentation/constants/constants.dart';
import 'presentation/other/application/view/application_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Realm realm;

  @override
  void initState() {
    super.initState();
    final config = Configuration.local(
      [Store.schema],
      migrationCallback: _migrationCallback,
      schemaVersion: 1,
      initialDataCallback: (realm) {
        // デバック時は初期データを作成する
        if (kDebugMode) TestSeeder().execute(realm);
      },
    );
    realm = Realm(config);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        storeRepositoryProvider.overrideWithValue(StoreRepositoryImpl(realm)),
        categoryRepositoryProvider.overrideWithValue(CategoryRepositoryImpl(realm)),
      ],
      child: MaterialApp(
        title: 'FreeMarketPos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          dividerTheme: const DividerThemeData(
            color: dividerColor,
            thickness: 1,
          ),
        ),
        home: const ApplicationScreen(),
      ),
    );
  }

  MigrationCallback get _migrationCallback => (Migration migration, int oldSchemaVersion) {
        // マイグレーション処理の記載箇所
      };
}
