import 'package:package_info/package_info.dart';

class GetVersion {
  GetVersion();

  Future<String> execute() async {
    // バージョン情報は取得元が変わることがないためユースケースで取得する
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
