library common_dependency_module;

export 'src/logger.dart';
export 'package:equatable/equatable.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
export 'package:cloud_firestore/cloud_firestore.dart';


/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
