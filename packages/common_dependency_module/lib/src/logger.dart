import 'package:logger/logger.dart';

final logger = Logger(
  filter: null,
  printer: PrettyPrinter(
    lineLength: 60,
    methodCount: 0,
  ),
  output: null,
);
