import 'dart:developer' show log;

import 'package:logging/logging.dart';

class LoggerHelper {
  static void init() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen(
      (record) {
        if (record.level == Level.SEVERE || record.level == Level.WARNING) {
          log(
            '${record.level.name}[${record.loggerName}]: ${record.message}'
            '\n\terror: ${record.error}.'
            '\n\tstack trace:\n ${record.stackTrace}',
          );
        } else {
          log('${record.level.name}[${record.loggerName}]: ${record.message}');
        }
      },
    );
    Logger.root.info("Logger initialized.");
  }
}
