import 'dart:convert';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:ticket_trove/common/utils/debug_log.dart';

Future<void> getPackageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  final packageInfoMap = packageInfo.data;
  // String version = packageInfo.version;
  // String buildNumber = packageInfo.buildNumber;

  debugLog(appName);
  debugLog(jsonEncode(packageInfoMap));
}
