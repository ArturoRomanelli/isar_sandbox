enum LoggerColor {
  black('30m'),
  red('31m'),
  green('32m'),
  yellow('33m'),
  blue('34m'),
  magenta('35m'),
  cyan('36m'),
  white('37m');

  const LoggerColor(this.colorCode);
  final String colorCode;
}
