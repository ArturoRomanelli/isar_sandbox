import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../logs/isar_sandbox_logs_color.dart';
import '../logs/isar_sandbox_observer.dart';
import 'isar_sandbox_logger.dart';

IsarSandboxObserver initProviderObserver() {
  final riverpodLogger = createRiverpodLogger();
  final observer = IsarSandboxObserver(riverpodLogger);

  return observer;
}

void initErrorReporting() {
  hierarchicalLoggingEnabled = true;
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is Trace) return stack.vmTrace;
    if (stack is Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  final baseLogger = createBaseLogger();
  FlutterError.onError = (details) => baseLogger.logger.severe(
        details.exceptionAsString(),
        details.exception,
        details.stack,
      );
}

IsarSandboxLogger createRiverpodLogger() {
  final riverpodLogger = Logger('Riverpod')..level = Level.FINEST;
  final logger = IsarSandboxLogger(logger: riverpodLogger, color: LoggerColor.white);

  riverpodLogger.onRecord.listen(logger.recordLogs);

  return logger;
}

IsarSandboxLogger createBaseLogger() {
  final baseLogger = Logger('Isar Sandbox')..level = Level.SEVERE;
  final logger = IsarSandboxLogger(logger: baseLogger, color: LoggerColor.magenta);

  baseLogger.onRecord.listen(logger.recordLogs);

  return logger;
}
