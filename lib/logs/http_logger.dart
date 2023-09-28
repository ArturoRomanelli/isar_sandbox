
import 'package:logging/logging.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';


import 'isar_sandbox_logs_color.dart';
import 'isar_sandbox_logger.dart';



part 'http_logger.g.dart';

@riverpod
Logger httpLogger(HttpLoggerRef ref) {



  final httpLogger = Logger('DIO')..level = Level.INFO;
  final logger = IsarSandboxLogger(logger: httpLogger, color: LoggerColor.green);

  final subscription = httpLogger.onRecord.listen(logger.recordLogs);

  ref.onDispose(subscription.cancel);

  return httpLogger;

}


