import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../clients/local_client.dart';
import '../clients/package_info.dart';
import '../src/cards/data/models/card_dto.dart';
import 'isar_sandbox_flavors.dart';

Future<List<Override>> initOverridesWith({required IsarSandboxFlavor flavor}) async {
  final packageInfo = await PackageInfo.fromPlatform();
  final isar = await _initializeIsar();

  return [
    flavorProvider.overrideWith((ref) {
      ref.keepAlive();
      return flavor;
    }),
    packageInfoProvider.overrideWith((ref) {
      ref.keepAlive();
      return packageInfo;
    }),
    localDbProvider.overrideWith((ref) {
      ref.keepAlive();
      return isar;
    }),
  ];
}

Future<Isar> _initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [CardDtoSchema],
    name: 'isar_sandbox',
    directory: dir.path,
    maxSizeMiB: 2 * Isar.defaultMaxSizeMiB,
    // ignore: avoid_redundant_argument_values
    inspector: kDebugMode,
  );

  return isar;
}
