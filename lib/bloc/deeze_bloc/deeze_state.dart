import 'package:flutter/foundation.dart' show immutable;

import '../../models/models.dart';

@immutable
abstract class DeezeState {
  const DeezeState();
}

class LoadingDeeze extends DeezeState {
  const LoadingDeeze();
}

// ignore: must_be_immutable
class LoadedDeeze extends DeezeState {
  Deeze? deeze;
  LoadedDeeze({this.deeze});
}

class ErrorDeeze extends DeezeState {
  const ErrorDeeze();
}
