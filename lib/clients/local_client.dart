import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_client.g.dart';

@riverpod
Future<Isar> localDb(LocalDbRef ref) async {
  throw UnimplementedError('This provider must be overridden');
}
